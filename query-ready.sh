#!/bin/bash

# query setting
echo -e "\033[32m[+] Git clone\033[0m $@"
read -p "Enter git clone address : " repository_url
directory_name=$(basename "$repository_url")
clone_directory_name="$directory_name"-repo

mkdir -p /home/codevuln/target-repo/$directory_name/$clone_directory_name

echo -e "\033[32m[+] git clone : /home/codevuln/target-repo/$directory_name/$clone_directory_name\033[0m $@"
git clone --depth=1 "$repository_url" "/home/codevuln/target-repo/$directory_name/$clone_directory_name"

mkdir "/home/codevuln/target-repo/$directory_name/sonarqube"

python3 <<END
from sonarqube import SonarQubeClient

url = "http://localhost:9000"
username = "admin"
password = "admin"

sonar = SonarQubeClient(sonarqube_url=url, username=username, password=password)
END

python3 query-action.py $directory_name $clone_directory_name
