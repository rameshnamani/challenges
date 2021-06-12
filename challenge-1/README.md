### A Simple 3-Tier environment

The Iaac tool used here is Terraform and Bash is for installating a sample java application. In this setup, a java application will be installed in the compute engine by getting the required software and the application from GCS bucket.

The repository has three files - 
1. main.tf
2. variables.tf
3. startup-script.sh

Below is the detailed on each of the file and why is it required.

**main.tf -** 

This is by far the most important file in this Setup. This file is used to setup the Compute Engine in GCP and run the installation script which we are passing to be executed after the machine boot up. The list of sources in this file are discussed 

* **Provider** : 
Terraform relies on plugins called "providers" to interact with cloud providers, SaaS providers, and other APIs. Terraform configurations must declare which providers they require so that Terraform can install and use them. Additionally, some providers require configuration (like endpoint URLs or cloud regions) before they can be used.

* **Data** : Data sources allow Terraform use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

* **Resource** : The resource block in the script is used to create the required compute instance. The variables which can required are parameterized using "var". 

**variables.tf -** 
This .tf file is used to declare the values for the variables defined in main.tf. For this usecase, we have just defined the values using "default" key for each variable. This can be optionally defined in .tfvars too but limited to variables.tf to keep it simple.


**startup-script.sh -** 

The metadata_startup_script is a optional parameter in main.tf which can be used to pass an installation script Compute Instance which will be created. This is executed once the instance is boot-up. We are leveraging this parameter and passing our startup-script.sh file.

In this script file, we are copying the required java software from Google Cloud Storage Bucket which we make it available prior to this setup. After java is installed successfully, we then copy the sample jar file from GCS. After this is complete, we use a linux command to run this jar file.



