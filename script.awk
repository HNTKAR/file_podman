{
#Docker file
print "\nRUN useradd "$1";\\">>"Dockerfile"
print "\techo "$2" | passwd --stdin "$1";\\">>"Dockerfile"
print "\techo -e \""$2"\\n"$2"\"| pdbedit -a -t -u "$1>>"Dockerfile"

#docker-compose file
print "      - \""$3":"$3"">>"docker-compose.yml"

print "["$1"]">>"smb.conf"
print "path = "$3"/"$1>>"smb.conf"
print "mkdir -p "$3"/"$1| "/bin/bash"
print "browsable = no">>"smb.conf"
print "read only = no">>"smb.conf"
print "create mode = 0744">>"smb.conf"
print "directory mode = 0744">>"smb.conf"
print "valid users = $dir_user">>"smb.conf"
print "">>"smb.conf"
}
