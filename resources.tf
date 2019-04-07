# Define webserver inside the public subnet
resource "aws_instance" "ahf" {
  ami  = "${var.aws_front_ami}"
  instance_type = "t1.micro"
  key_name = "${var.aws_key_name}"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgahf.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  tags {
    Name = "ah_frontend"
  }
}

resource "aws_instance" "ahdoc" {
  ami  = "${var.aws_docu_ami}"
  instance_type = "t1.micro"
  key_name = "${var.aws_key_name}"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgahf.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  tags {
    Name = "ah_documentation"
  }
}


# Define database inside the private subnet
resource "aws_instance" "ahdb" {
  ami  = "${var.aws_db_ami}"
  instance_type = "t1.micro"
  key_name = "${var.aws_key_name}"
  subnet_id = "${aws_subnet.private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgahb.id}"]
  source_dest_check = false

  tags {
    Name = "ah_database"
  }
}


resource "aws_key_pair" "exist_key" {
  key_name = "terranet"
  public_key = "${file("${var.key_path}")}"
}