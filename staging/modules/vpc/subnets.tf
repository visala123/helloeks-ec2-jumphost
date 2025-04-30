resource "aws_subnet" "public-webtier-subnet-1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public-webtier-subnet-1-cidr
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "stage-eks-cluster-subnet-public1-ap-northeast-2a"
  }
}

####  public Subnet 2 - Webtier  ###

resource "aws_subnet" "public-webtier-subnet-2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public-webtier-subnet-2-cidr
  availability_zone       = "ap-northeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "stage-eks-cluster-subnet-public2-ap-northeast-2b"
  }
}


