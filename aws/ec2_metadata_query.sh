#!/bin/bash
# On an EC2 instance, will query the reserved IP to 
# gain more information about the system. Note: This is not
# intended to enumerate everything. Just show a blueprint of 
# what you can enumerate.
echo $'curl http://169.254.169.254/latest/meta-data/\n-----'
curl http://169.254.169.254/latest/meta-data/
echo $'\n\n'

echo $'curl http://169.254.169.254/latest/user-data/\n-----'
curl http://169.254.169.254/latest/user-data
echo $'\n\n'

echo "Warning: This next one has no value, it's just weird!"
echo $'curl curl http://169.254.169.254/latest/meta-data/identity-credentials/ec2/security-credentials/ec2-instance/\n-----'
curl http://169.254.169.254/latest/meta-data/identity-credentials/ec2/security-credentials/ec2-instance
echo $'\n\n'

echo "Dumping environment variables with 'env'"
env
