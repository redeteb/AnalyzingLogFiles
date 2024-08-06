Connect to instance, start at /home/ubuntu

-Create script
Command: 
nano auth_log_creation.sh
Copy and paste in the provided script 

-Change script permissions then run
Commands: 
chmod +x auth_log_creation.sh
./auth_log_creation.sh

-Check if logs were created
Command:
cd /var/log/auth_log.log
(Success!)

-Search through the log for lines containing the keywords: “Failed,” “Unauthorized,” and “Invalid.”  Once found, write the line into a new file, /home/ubuntu/suspicious_activity.log
Command:
grep -E -i "failed|unauthorized|invalid" auth_log.log >> /home/ubuntu/suspicious_activity.log

-Check if new file /home/ubuntu/suspicious_activity.log was properly created and contains the right information
Command:
cat /home/ubuntu/suspicious_activity.log
(Sucess!)


-Automate script to run daily 
Command:
nano /home/ubuntu/filter_auth_log.sh (Creates a script that will keep track of the last line in auth_log.log processed to avoid duplicating entries)
chmod +x filter_auth_log.sh
crontab -e 0 19 * * 1-7 /home/ubuntu/filter_auth_log.sh (Runs script everyday at 7pm starting today, Monday)

