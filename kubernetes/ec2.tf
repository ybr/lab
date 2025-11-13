resource "aws_instance" "kubernetes" {
  ami           = "ami-0d3684aec6d12c883" # Amazon Linux 2023 Kernel 6.1
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.kubernetes.id]
  key_name = aws_key_pair.kubernetes.key_name

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_key_pair" "kubernetes" {
  key_name   = "kubernetes"
  public_key = file("~/.ssh/kubernetes.pub")
}

resource "aws_security_group" "kubernetes" {
  name   = "kubernetes"
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = "kubernetes"
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["91.169.211.174/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}