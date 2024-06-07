Here's a basic README file for the MySQL database creation task using Ansible:

# ivolve 
## lab6
## Ansible MySQL Database Creation

** note that i use the linux academy worksatation**

This Ansible playbook automates the process of creating a MySQL database and user on a remote server. It utilizes Ansible's capabilities to manage MySQL packages, services, databases, and users.

## Prerequisites

- Ansible installed on the control node.
- SSH access to the target server(s) where MySQL will be installed.
- MySQL root access or a user with sufficient privileges to create databases and users.

## Usage

1. **Set Up Inventory**: Create an inventory file named `inventory` and define the IP address or hostname of the target MySQL server(s).

    ```ini
    10.0.2.15
    ```

2. **Create Ansible Vault File**: Create a vault file named `vault.yml` to securely store MySQL credentials.

    ```bash
    ansible-vault create vault.yml
    ```

    Add the following content to the vault file:

    ```yaml
      mysql_root_password: root123
      db_user_password:    ahmed123
   
    ```
   And use the file '.secret.txt' to contan the vault file password 
   and use this file in the "ansible.cfg" file
   ```
      vault_password_file = .secret.txt
   ```
3. **Run the Playbook**: Execute the Ansible playbook to create the MySQL database and user.

    ```bash
    ansible-playbook -i hosts.ini playbook.yml --ask-vault-pass 
    ```

4. **Verification**: Connect to the MySQL server and verify the database and user creation using SQL commands:

    