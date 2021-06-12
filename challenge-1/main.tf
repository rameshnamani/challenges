#GCP credentials and project ID 
provider "google" { 
  credentials = file(var.credentials) 
  project     = var.project-id 
  region      = var.region 
} 
  
data "template_file" "startup-script" {
 template = file(startup-script.sh)
  
  vars = {
    software-bucket = var.usr-software-bucket
    java-version = var.usr-java-version
  }
}

#Launch Compute Instance
resource "google_compute_instance" "myinstance" { 
  name         = var.instance-name
  machine_type = var.machine-type 
  zone         = var.zone 
  boot_disk { 
    initialize_params { 
      image = "centos-7-v20190729" 
      size = "100" 
    } 
  } 

  metadata_startup_script = data.template_file.startup-script.rendered 

#Network Configurations
  network_interface { 
        network       = var.vpc-name
        subnetwork    = var.subnet
        access_config{
        }
  }
  
  service_account { 
   scopes = ["cloud-platform"]
    } 
} 

 
