# Terraform deployment aws

Terraform deployment of a webserver (NGINX). Terraform's state file is kept on a S3 backend with state locking support.
This setup includes a launch configuration that runs a script to pull the necessary files from an S3 bucket and execute an ansible playbook. 
It has a load balancer, autoscaling, cloudwatch alarms to send notifications when ASG state changes, and scaling policies.

The status-bucket.tf file inside state-bucket must be executed first to create the state bucket, and locking support.  
