#!/bin/bash 
yum install httpd -y
yum install  telnet -y 
sudo systemctl start httpd 
sudo systemctl enable httpd 
