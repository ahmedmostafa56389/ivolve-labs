# ivolve internship

## Ansible Lab4 " ansible ad-hoc "
This project involves configuring and managing a host using SSH keys for secure access. The objective is to enable passwordless SSH access to the host from my server.


## Steps to Add Your Public Key to the host

### 1. Generate an SSH Key Pair (if not already done)

If you don't already have an SSH key pair on your lab machine, generate one using the following command:

```bash
ssh-keygen -t rsa -b 2048
```

### 2. Copy Your Public Key to the host

```
 cat /root/.ssh/id_rsa.pub | ssh -i host1.pem ahmed@192.18.1.45 'cat >> ~/.ssh/sh121259'
```
### 3. create inventory and ansible.cfg to using defulats

show the inventory
```
[web_servers]

serverb

[db_servers]

servera
```
### 4. Verify Ansible ad-hoc command 
```
ansible -i inventory all -m ping
```


![Alt text](run.png)