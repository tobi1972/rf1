#!/bin/bash
sudo apt install apache2  telnet -y
sudo systemctl start apache2
sudo systemctl enable apache2