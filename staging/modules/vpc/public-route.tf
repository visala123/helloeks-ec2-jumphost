# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # public 
    gateway_id = aws_internet_gateway.igw.id
  }
  /*route {
    cidr_block = "10.40.0.0/18" # public 
    gateway_id = "local"
  }*/
  tags = {
    "Name" = "stage-eks-cluster-rtb-public"
  }
}


# Route Table Association
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.public-webtier-subnet-1.id
  route_table_id = aws_route_table.rt.id
 }
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public-webtier-subnet-2.id
  route_table_id = aws_route_table.rt.id
  
}