{
#Docker file
print "\nRUN useradd "$1"&&\\">>"Dockerfile"
print "\techo "$2" | passwd --stdin "$1"&&\\">>"Dockerfile"
print "\tmkdir -m 2777 -p "$3"/"$1"&&\\">>"Dockerfile"
print "\techo \"local_root="$3"/"$1"\">> /etc/vsftpd/vsftp_user_conf/"$1 >>"Dockerfile"

#docker-compose file
print "      - "$3"/"$1":"$3"/"$1>>"docker-compose.yml"
}
