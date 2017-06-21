# Adding a Sudo User
```
$ (sudo) adduser username
$ (sudo) usermod -aG sudo username
```

# SSH Port Forwarding
* Add a user to the EC2 instance (`claws1`). e.g. use the same username across remote laptop (`clmac1`), dev server (`cldev1`), and ec2 (`claws1`).
* Add public keys of `cldev1` and `claws1` to each other's `~/.ssh/authorized_keys`
* Add public key of `clmac1` to `cldev1` and `claws1`'s `~/.ssh/authorized_keys`
* Edit `/etc/ssh/sshd_config` as follows:
```
AllowTcpForwarding yes # allow port forwarding
GatewayPorts yes       # allow remote hosts to connect to port forwarded for the client
PermitOpen claws1:22   # the destinations to which TCP port forwarding is permitted
```
* Create a bash script to open a connection from cldev1 to claws1 with port forwarding
```
#!/bin/bash                                                                    
createTunnel() {                                                               
    /usr/bin/ssh -f -N -R 65432:localhost:22 -L 65433:claws1:22 claws1
	if [[ $? -eq 0 ]]; then
		echo Tunnel to claws1 created successfully
	else
		echo An error occurred creating a tunnel to claws1. Return code: $?
	fi
}

out=$(ssh claws1 'ssh -p 65432 localhost ls' 2>&1 /dev/null)
if [[ $out != ssh* ]]; then
	echo Creating new tunnel connection to claws1
	createTunnel
fi
```
* Create a cron job to check the connection and open it if necessary
```
# m h  dom mon dow   command
01,11,21,31,41,51  *   *   *   *   /home/jeong/tools/ssh_port_forwarding.sh
```
* Open a SSH connection from `clmac1` to `claws1`.
* Open a SSH connection from `claws1` to `localhost` with the port for forwarding, 65432.

# Recording and Replaying a Terminal
```
$ script --timing=script.tsp script.log
Script started, file is script.log
...
$ exit
$ scriptreplay --timing=script.tsp script.log
```
