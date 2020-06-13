> ERROR: Couldn't connect to Docker daemon at http+docker://localhost - is it
    running?

- `systemctl start docker`
- `service docker start`

> ssh: connect to host ec2-1.2.3.4.eu-west-1.compute.amazonaws.com port 22: Connection timed out

- Check the inbound IP address whitelist in EC2 security groups.
