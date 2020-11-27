#!/bin/bash
sudo echo -e '[r1soft]  \nname=R1Soft Repository Server \nbaseurl=http://repo.r1soft.com/yum/stable/$basearch/ \nenabled=1 \ngpgcheck=0' > /tmp/r1soft.repo
