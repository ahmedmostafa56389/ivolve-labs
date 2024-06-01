resource "aws_vpc" "ivolve" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "ivolve_igw" {
  vpc_id = aws_vpc.ivolve.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.ivolve.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ivolve.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ivolve_igw.id
  }
}

resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)
  vpc_id     = aws_vpc.ivolve.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)
}
