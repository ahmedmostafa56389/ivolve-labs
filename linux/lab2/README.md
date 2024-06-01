# ivolve-OJT
## Lab2 aws
### Test pin using bash script

This is a simple Bash script named `test_ping.sh` to ping all devices in a given subnet (`192.168.1.0/24`). 
The script pings each IP address in the subnet and reports whether the host is up or down.

### Usage

1. Clone the repository or download the `test_ping.sh` script to your local machine.
2. Make the script executable:
   ```sh
   chmod +x test_ping.sh
   ```

3. Run the script 
    ```sh
   ./test_ping.sh
   ```

### Example Output

 ```sh
   server 192.168.1.1 is up and running 
   server 192.168.1.2 is up and running
   server 192.168.1.3 is unreachable
   server 192.168.1.4 is unreachable
  ```
 
