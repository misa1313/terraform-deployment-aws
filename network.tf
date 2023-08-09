variable "avail_zone" {
}

resource "aws_subnet" "subnet-2-1" {
  vpc_id            = aws_vpc.vpc-2.id
  cidr_block        = "10.245.10.0/24"
  availability_zone = var.avail_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-2-1"
  }
}

resource "aws_subnet" "subnet-2-2" {
  vpc_id            = aws_vpc.vpc-2.id
  cidr_block        = "10.245.13.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-2-2"
  }
}

resource "aws_internet_gateway" "gateway-2" {
  vpc_id = aws_vpc.vpc-2.id
}

resource "aws_route_table" "route_table-2" {
  vpc_id = aws_vpc.vpc-2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway-2.id
  }
  tags = {
    Name = "route_table-2"
  }
}

resource "aws_route_table_association" "association-2" {
  subnet_id      = aws_subnet.subnet-2-2.id
  route_table_id = aws_route_table.route_table-2.id
}

resource "aws_route" "route-2" {
  route_table_id         = aws_route_table.route_table-2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway-2.id
}

resource "aws_security_group" "security_group-2" {
  name        = "allow_http_ssh"
  description = "Allow HTTP/SSH inbound traffic"
  vpc_id      = aws_vpc.vpc-2.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}

resource "aws_route53_zone" "route53-2" {
  name = "aws.kinntel.com"
}

resource "aws_route53_record" "route53-record-test" {
  zone_id = aws_route53_zone.route53-2.zone_id
  name    = "aws.kinntel.com"
  type    = "A"
  alias {
    name                   = aws_lb.load_balancer-2.dns_name
    zone_id                = aws_lb.load_balancer-2.zone_id
    evaluate_target_health = false
  }
}
