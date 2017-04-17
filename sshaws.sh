sshaws() {
    #   
    # sshaws <ec2_instance_name_tag> <ec2_user> 
    #   
    # note:
    #   - If instances has the same name, the first one will be picked
    #   - This function gets the aws private ip
    #   
    DEF_EC2_USER='<DEFAULT_USER>' 
    DEF_PEMFILE='<DEFAULT_PEM>'
        
    # check if ec2_user is set
    # otherwise set to default
    if [ -e $2 ]; then
        2=$DEF_EC2_USER
    fi  

    # get aws ec2 instance ip
    AWS_IP=$(aws ec2 describe-instances \
        --max-items 1 \
        --filters "Name=tag-value,Values=$1" \
        --query 'Reservations[0].[Instances[0].PrivateIpAddress]' \
        | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{2,3}')
  
    if [[ ! -z "${AWS_IP}" ]] ; then
        ssh -i $DEF_PEMFILE $2@$AWS_IP
    fi  
}
