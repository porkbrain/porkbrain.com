#!/bin/sh
# Builds the application for production.

set -e

for key in "$@"; do
    case ${key} in
        --pem)
        pem_file_path=$2
        ;;
        -i|--instance)
        instance_name=$2
        ;;
        -h|--help)
        echo "Usage:
            --pem           Path to the pem file for ssh.
            -i|--instance   Remote instance to ssh to.
        "
        exit 0
        ;;
    esac
    # go to next argument
    shift
done

if [ -z "${instance_name}" ]; then
    echo "Name of the instance must be provided with --instance."
    exit 1
fi

if [ ! -f "${pem_file_path}" ]; then
    echo "Path to the .pem file must be provided with --pem ."
    exit 1
fi

# Generates 256 random bytes.
export SECRET_KEY_BASE=$(head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-' | fold -w 256 | head -n 1)
# TODO: Grab a DB pwd and API key from the env vars.
export API_TOKEN=${API_TOKEN:-"secret"}
db_pwd=${DB_PWD:-"secret"}
export DATABASE_URL="ecto://porkbrain:${db_pwd}@porkbrain-postgres/porkbrain"

echo "Compiling the Elixir project"
mix deps.get
mix deps.get --only prod
MIX_ENV=prod mix compile
echo "Compiling assets"
npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

echo "Building the release file"
MIX_ENV=prod mix release

app_location="_build/prod/rel/porkbrain"
eval "${app_location}/bin/porkbrain version"

# We already assume that the EC2 instance is running docker. Although if we are
# to provision the machine from scratch, we have to install the set it up with
# sudo yum update -y
# sudo yum install -y docker
# sudo usermod -aG docker ec2-user
# sudo service docker start
# mkdir logs
# mkdir data
#
# Create the network.
# docker network create -d bridge porkbrain-net
#
# Don't forget to change the password.
# docker run -d --rm \
#     -p 5432:5432 \
#     -v ~/data:/var/lib/postgresql/data \
#     -v ~/logs:/logs \
#     -e POSTGRES_PASSWORD=secret \
#     -e POSTGRES_USER=porkbrain \
#     --network porkbrain-net \
#     --name porkbrain-postgres \
#     postgres


run_ssh_cmd() {
    echo $(ssh -t -i $pem_file_path $instance_name "$1")
}

# Creates a dir for the compiled files if not exists yet.
run_ssh_cmd "mkdir -p ~/server"

# Copies the binary over.
rsync -avz -e "ssh -i ${pem_file_path}" "${app_location}" "${instance_name}":"~/server"

# Copies docker related files.
scp -i $pem_file_path "deployment_assets/Dockerfile" $instance_name:"~/server/Dockerfile"
scp -i $pem_file_path "deployment_assets/.dockerignore" $instance_name:"~/server/.dockerignore"

# Builds the image with the app
run_ssh_cmd "cd ~/server && docker build --tag porkbrain ."

# Runs the show.
run_ssh_cmd "cd ~/server && docker run --rm -d -p 80:4000 -p 443:443 --name porkbrain --network porkbrain-net porkbrain"
