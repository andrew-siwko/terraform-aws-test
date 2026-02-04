## Andrew's Multicloud Terraform Experiment
# Goal
The goal of this repo is to create a usable VM in the AWS cloud.
Everything here was done using the AWS free trial.
After this step completed I uses ansible to configure and install Tomcat and run a sample application.

# Multicloud
I tried to build the same basic structures in each of the cloud environments.  Each one starts with a providers, lays out the network and security, creates the VM and then registers the public IP in my DNS.  There is some variability which has been interesting to study.
* Step 1 - [AWS](https://github.com/andrew-siwko/terraform-aws-test) (you are here)
* Step 2 - [Azure](https://github.com/andrew-siwko/terraform-azure-test)
* Step 3 - [GCP](https://github.com/andrew-siwko/terraform-gcp-test)
* Step 4 - [Linode](https://github.com/andrew-siwko/terraform-linode-test)
* Step 5 - [IBM](https://github.com/andrew-siwko/terraform-ibm-test)

# Build Environment
I stood up my own Jenkins server and built two freestyle jobs to support the Terraform infrastructure builds.  The main job calls 
* terraform init
* terraform plan
* terraform apply -auto-approve
* terraform output (This is piped to mail so I get an e-mail with the outputs.)

Yes, I know plan and apply should be separate and intentional.  In this case I found defects in planwhich halted the job before apply.  I also commented out apply untuil plan was pretty close to working.
The Jenkins job contains environment variables with authentication information for the cloud environment and Linode (my registrar).

The second Jenkins job imports my DNS zone.  I run it only once after the plan is complete.  After that Terraform happily manages records in my existing zone.

