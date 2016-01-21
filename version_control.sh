#/bin/sh
#month file will be created
DATE=$(date +"%B")
Directory="/tmp/ansible_endTB/bahmni"
#create the bahmni directory if it doesnot exist or zip(backup old bahmni directory) if exists and delete remove directory if it exists
if [ -d "$Directory" ]; then
tar -cf $Directory-$DATE.tar $Directory
rm -rf $Directory
mkdir $Directory
else
mkdir $Directory
fi
#cd into directory
cd $Directory
#get the contents from the website below and read its content into a file
#the 0 should change as version changes(figure out the best way to list latest version without stating number(0))
content= wget -q -O- https://bintray.com/bahmni/rpm/bahmni-installer/view#files/rpms | grep -e "bahmni-installer/0" > bahmni_installer_content.txt
#read the bahmni_installer_content file and bring the latest installer version(looks like they are listed in a format of latest version first)(would be better if this can be converted from string to int,then compare
# latest version)
head -1 $Directory/bahmni_installer_content.txt > latest_version_of_bahmniInstaller.txt
# search for the version number, copy it to a new file, remove the -(| sed 's/\-//g'() to facilitate converting string to integer
awk -F'title="' '{print $2}' $Directory/latest_version_of_bahmniInstaller.txt |rev | cut -c 3- | rev  > bahmni_versionNumbers.txt
# read file and add version number to the download url of the bahmni-installer
while read line
do
#MD5SUM?
wget https://bintray.com/artifact/download/bahmni/rpm/rpms/bahmni-installer-${line}.noarch.rpm
#install the bahmni installer(This is because, I still can't figure out the best way to do this in ansible because I can't find the best way to include the new installer version(-y is for yes)
#if the package is already installed do nothing
#if rpm -qa | grep bahmni > /dev/null 2>&1; then
yum -y install /tmp/ansible_endTB/bahmni/bahmni-installer-${line}.noarch.rpm
#else
#echo "bahmni installer exists"
#fi
done < $Directory/bahmni_versionNumbers.txt





###############################################
######possibilty of building upon the below
# content= wget -q -O- https://bintray.com/bahmni/rpm/bahmni-installer/view#files/rpms | grep -e "bahmni-installer" > bahmni_installer_content.txt
#awk -F'title="' '{print $2}' $Directory/latest_version_of_bahmniInstaller.txt |rev | cut -c 3- | rev | sed 's/\-//g'   > bahmni_versionNumbers.txt
# convert the strings in latest_versionNumber.txt to int
#cat $Directory/bahmni_versionNumbers.txt | while read line; d
#read -a var <<< $(sort -t= -nr -k3 $Directory/bahmni_versionNumbers.txt | head -1
#while read A
#do
 ##   read B
#    read C
#  if  [ "$A" -gt "$B" ]; then echo "$A";
#  fi
#done < $Directory/bahmni_versionNumbers.txt