resource "aws_instance" "roboshop-docker" {
    ami = local.ami_id
    instance_type = "t3.medium"
    vpc_security_group_ids = [aws_security_group.allow_all_docker.id]

    root_block_device {
      volume_size = 50
      volume_type = "gp3"
    }
    user_data = file("docker.sh")

    tags = {
        Name ="${var.project}-${var.environment}-docker"

        docker="true"
    }
    
    }



  

resource "aws_security_group" "allow_all_docker" {
    name = "allow-all-docker" 
    description = "sg for docker"

    ingress {
        
        from_port=0
        to_port=0
        protocol=-1
        cidr_blocks=["0.0.0.0/0"]
        ipv6_cidr_blocks=["::/0"]
        
        
    }
    
    egress{
        from_port=0
        to_port=0
        protocol=-1
        cidr_blocks=["0.0.0.0/0"]
        ipv6_cidr_blocks=["::/0"]

    }
    

    lifecycle {
      create_before_destroy = true
    }
    tags = {
      Name = "docker-sg"
    }
  
}