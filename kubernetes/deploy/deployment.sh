#!/bin/sh

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log.out 2>&1

# Create/Update PersistentVolume for MySQL
echo "Appying PersistentVolume for MySQL..."
kubectl apply -f ../mysql/persisntentvolume.yml

# Create/Update PersistentVolumeClaim for MySQL
echo "Appying PersistentVolumeClaim for MySQL..."
kubectl apply -f ../mysql/pvclaim.yml

# Create/Update Secrets for MySQL
echo "Appying Secrets for MySQL..."
kubectl apply -f ../mysql/secret.yml

# Create/Update Deployment for MySQL
echo "Appying Deployment for MySQL..."
kubectl apply -f ../mysql/deployment.yml

# Create/Update Service for MySQL
echo "Appying Service for MySQL..."
kubectl apply -f ../mysql/service.yml

# Create/Update Deployment for PhpMyAdmin
echo "Appying Deployment for PhpMyAdmin..."
kubectl apply -f ../phpmyadmin/deployment.yml

# Create/Update Service for PhpMyAdmin
echo "Appying Service for PhpMyAdmin..."
kubectl apply -f ../phpmyadmin/service.yml

# Create/Update PersistentVolume for WordPress
echo "Appying PersistentVolume for WordPress..."
kubectl apply -f ../wordpress/persisntentvolume.yml

# Create/Update PersistentVolumeClaim for WordPress
echo "Appying PersistentVolumeClaim for WordPress..."
kubectl apply -f ../wordpress/pvclaim.yml

# Create/Update Deployment for WordPress
echo "Appying Deployment for WordPress..."
kubectl apply -f ../wordpress/deployment.yml

# Create/Update Service for WordPress
echo "Appying Service for WordPress..."
kubectl apply -f ../wordpress/service.yml

