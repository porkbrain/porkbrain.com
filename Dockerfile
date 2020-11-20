# Elixir + Phoenix
# Taken from https://github.com/fireproofsocks/phoenix-docker-compose

FROM elixir:1.11.2

# Install debian packages
RUN apt-get update
RUN apt-get install -y \
    build-essential inotify-tools \
    postgresql-client \
    rsync wget

# Install Phoenix packages
RUN mix local.hex --force
RUN mix local.rebar --force
RUN wget https://github.com/phoenixframework/archives/raw/master/1.4-dev/phx_new.ez && \
    mix archive.install --force ./phx_new.ez

# Install node
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs
RUN nodejs -v

# Install npm
# https://askubuntu.com/a/1057748/1018188
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt-get -y update && apt-get -y install yarn
RUN npm --version

WORKDIR /app
EXPOSE 4000
