# Startup script for running a simple java application.

echo "Copying the Java JDK from software bucket"
mkdir -p /deployments/installs/java
gsutil cp -r gs://${software-bucket}/Java_JDK/${java-version}/*.rpm /deployments/installs/java

echo "Copying java from bucket is complete. Performing installation.."
yum -y localinstall /deployments/installs/java/*.rpm 

echo "Validate if the installation is successful.."
java -version

if [ "$(echo $?)" == "0"]
then
  echo "Java installation is complete. Proceed to deploy the application jar"
else
  echo "Java installation is FAILED. Exiting setup.!"
   exit 1
fi

echo "Copy the java application jar from the software bucket.."
mkdir -p /deployments/java_apps /var/log/applications
gsutil cp gs://${software-bucket}/myApp/java_app.jar /deplopments/java_apps/
java -jar /deplopments/java_apps/java_app.jar &> /var/log/applications/application.log

echo "Setup complete and the application is available on port - 8080"

