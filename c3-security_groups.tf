#create security group -ssh traffic
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "This is the DEV VPC SSH"
  # vpc_id      = aws_vpc.main.id #if we leave this out it will use the default vpc
  ingress {
    description = "Allow port 22 (ssh)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #square brackets are list allows multiple items
  }

  egress {
    description = "Allow all ip and ports outbounds"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-ssh"
  }
}



# create security group - web traffic
resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "This is the DEV VPC WEB"
  # vpc_id      = aws_vpc.main.id #if we leave this out it will use the default vpc
  ingress {
    description = "Allow port 80 (web)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #square brackets are list allows multiple items
  }
  ingress {
    description = "Allow port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #square brackets are list allows multiple items
  }

  egress {
    description = "Allow all ip and ports outbounds"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-web"
  }
}