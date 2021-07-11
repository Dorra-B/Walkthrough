#!/bin/bash


#Step (1): Create the cluster
aws ecs create-cluster --cluster-name Walkthrough

#Step (2): Add the instances
echo ECS_CLUSTER=your_cluster_name >> /etc/ecs/ecs.config

#Step (3.0): Run a quick check
aws ecs list-container-instances --cluster Walkthrough

#Step (3.1): Dig deeper into the instances 
#Get the UUID of the instance
UniqID=$(aws ecs describe-container-instances --cluster default --container-instances container_instance_UUID)

#Get the details of the instance
ecs describe-container-instances --cluster Walkthrough --container-instances $UniqID


#Step (4.0):Creating the task 
#View the nginx_task.json file 

#Step (4.1):Creating the task 
aws ecs register-task-definition --family Walkthrough --container-definitions file://$HOME/nginx_task.json

#Step (5):Run the Task
aws ecs run-task --cluster Walkthrough --task Walkthrough:1 --count 1

#Step (6):Test the container
#/dev/null directory is used for disposing of unwanted output streams of a process
curl -v 54.173.144.196 >> /dev/null
