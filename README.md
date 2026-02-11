# Andrew's Multicloud Terraform Experiment
## Goal
The goal of this repo is to create a usable VM in the AWS cloud.<br/>
Everything here was done using the AWS free trial.<br/>
After this step completed I used Ansible to configure and install Tomcat and run a sample application.  [More on that later...](https://github.com/andrew-siwko/ansible-multi-cloud-tomcat-hello)<br/>
It all starts with the [Cloud Console](https://aws.amazon.com/).

## Multicloud
I tried to build the same basic structures in each of the cloud environments.  Each one starts with providers (and a backend), lays out the network and security, creates the VM and then registers the public IP in my DNS.  There is some variability which has been interesting to study.  The Terraform state file is stored on each provider.
* Step 1 - [AWS](https://github.com/andrew-siwko/terraform-aws-test) (you are here)
* Step 2 - [Azure](https://github.com/andrew-siwko/terraform-azure-test)
* Step 3 - [GCP](https://github.com/andrew-siwko/terraform-gcp-test)
* Step 4 - [Linode](https://github.com/andrew-siwko/terraform-linode-test)
* Step 5 - [IBM](https://github.com/andrew-siwko/terraform-ibm-test)

## Build Environment
I stood up my own Jenkins server and built a freestyle job to support the Terraform infrastructure builds.
* terraform init
* _some bash to import the domain (see below)_
* terraform plan
* terraform apply -auto-approve
* terraform output (This is piped to mail so I get an e-mail with the outputs.)

Yes, I know plan and apply should be separate and intentional.  In this case I found defects in plan which halted the job before apply.  That was useful.  I also commented out apply until plan was pretty close to working.<br/>
The Jenkins job contains environment variables with authentication information for the cloud environment and [Linode](https://www.linode.com/) (my registrar).<br/>
I did have a second job to import the domain zone but switched to a conditional in a script.  The code checks to see whether my zone record has been imported.  If not, the zone creation will fail.
```bash
if ! terraform state list | grep -q "linode_domain.dns_zone"; then
  echo "Resource not in state. Importing..."
  terraform import linode_domain.dns_zone 3417841
else
  echo "Domain already managed. Skipping import."
fi
```

## Observations
* This was my very first Terraform experience and my first cloud provider.  
* I know that Terraform handles dependencies but I developed a crude file naming scheme to keep my deployment tasks ordered in my mind and VSCode.
* The aws cli installed easily and was critical to success.
* I had to create the bucket with the cli as I did not know how to do that with Terraform.
* I had trouble selecting the image and instance type.  Only certain instances were allowed on the free plan.  I used the cli to search and started with t3.micro.
* At the beginning of this project I wanted to create multiple nodes.  I think I had 4 VMs at the beginning.  Once I hit the limits of the free plan and had a similar experience with Microsoft, I cut the project back to a single instance.
* I settled on m7i-flex.large after I ran out of memory while provisioning with Ansible.
* I had an issue with the default VPC.  If I did not define a unique VPC, Terraform would try to destory the default every time it detroyed and rebuilt the instance.  This hung the Terraform job.
* The admin user is ec2-user.  I observed that I could change the authorized key in Terraform but only recreating the instance would update the key.
* The AWS console was fairly simple to use but there were so many options, it was hard to focus on the job at hand.
* Amazon was in the process of adding MFA which was cumbersome to use.  I added MFA using Chrome (Google Password Manager?) on a Linux laptop and when I got back to Windows I had to fall back to e-mail authentication.
* I spent about 2 weeks getting the whole project working.
* Project stats:
  * Start: 2026-01-14
  * Functional: 2026-01-28
  * Number of Jenkins builds to success: 80
  * Hurdles: 
    * This was my first time using Terraform and doing cloud deployments.
    * Finding the right image
    * default VPC (my error)
