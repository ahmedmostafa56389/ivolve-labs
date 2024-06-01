# ivolve-OJT
## Lab22 aws
### Access Key
In This lab i get acces to my aws account through CLI .
get my Access Key and Secrt Access Key
![alt text](D:\ivolve\aws\lab22\key.png)

#### Create bucket
Then i create an aws S3 bucket 
 ```sh
    aws s3api create-bucket --bucket mostafa-lab22 --region us-east-1
```
### Upload files
Run this command to apload files to my bucket
```sh
   C:\Users\ahmed>aws s3 cp C:\Users\ahmed\Downloads\photo.jpeg s3://mostafa-lab22/
```

### Download files
Run this command to download any files from my bucket to my locapc
```sh
   C:\Users\ahmed>aws s3 cp s3://mostafa-lab22/photo.jpeg C:\Users\ahmed\
```
### enable virsioning 
I run this command to enable file versioning to upload multible versions from my file
```sh
   C:\Users\ahmed>aws s3api put-bucket-versioning --bucket mostafa-lab22 --versioning-configuration Status=Enabled
```
![alt text](D:\ivolve\aws\lab22\enable.png)



1. Clone the repository or download the `lab3-ping.sh` script to your local machine.
2. Make the script executable:
   ```sh
   chmod +x lab3-ping.sh
   ```

3. Run the script 
    ```sh
   ./lab3-ping.sh
   ```

### Example Output

 ```sh
    server 192.168.1.1 is up and running 
    server 192.168.1.2 is up and running
    server 192.168.1.3 is unreachable
    server 192.168.1.4 is unreachable
  ```

 
