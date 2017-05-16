awsname() {
    #   
    # awsname <ec2_instance_name_tag>
    #   
    
    # get aws ec2 instance ip
    AWS_NAME=$(aws ec2 describe-instances \
        --filters "Name=tag-value,Values=*$1*" \
        --query 'Reservations[*].[Instances[*].Tags[?Key==`Name`].Value]' \
        | grep -Eo '".*"' | sed 's/"//g')
    echo $AWS_NAME  
}
