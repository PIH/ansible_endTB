# ansible_endTB
Playbook to install bahmni(endTB) on a freshly installed centOS

This is tested in vagrant “nrel/CentOS-6.5-x86_64”

Clone the folder to /tmp

cd /tmp/ansible_endTB

./installAnsible.sh

Run the play book

ansible-playbook main

Note:
change the bahmni_ntp_timezone to the appropriate timezone.

For 
