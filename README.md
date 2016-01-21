# ansible_endTB
Playbook to install bahmni(endTB) on a freshly installed centOS

This is tested in vagrant "nrel/CentOS-6.5-x86_64"  
(vagrant init nrel/CentOS-6.5-x86_64  )

Clone the folder to /tmp

cd /tmp

git clone https://github.com/PIH/ansible_endTB

cd /tmp/ansible_endTB

./installAnsible.sh

Run the play book

ansible-playbook main

Note:

change the bahmni_ntp_timezone to the appropriate timezone.

If you want to install bahmni other than endtb bahmni, change implementation_name to default in /etc/bahmni-installer/setup.yml
