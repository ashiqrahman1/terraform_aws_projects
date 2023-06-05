resource "aws_key_pair" "sshkey" {
  key_name   = "terraform-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4hHp51J8MD7G2myJirx+J12CCXIdKP6wHPw+cmA25RNUua2rqiZpdi5eCCANaA9noztsh1fF4gaDC7oyPOxXlg8/hLFLbVXuDQE1FoMb6a0PI+IGMsxH4qW45uARKoRLgPs5Vl3eI2wXb2+V3JG96wKkis4+9lKFzGot1+VZP8Y1IPdVkdfj/Ey2Sqt7/8Zy6j//WRs5QStxoaYvnlgw1sEfst6SJpxRo/KmAWBTb7fJnUXhFsiH5lkvyvirer5PadPmhfUdYdIT74vDu2yDAsd7V6/zWYxM9UpbWHKz5w6qzSy0F1NmoNYH0SSp1jJ0jG/bwFjVDJG4luEmmEXhcfx8XyLHSgcmkpJiPOgwLrMt6M5k2NK5riXa+k9dyhiN8Dte7FujW8aJkeH9JYaR6iGVpVKFM2NxvfU1PvB0IIbvwEeNQgCzHa1+Goeuv5DpVoDAzsnwS6p9s6bphTe4KYjx9odW/KlHhm9nxMHzgA+kOhRorixIndZtjoE5LlPU= ashik@ubuntu"
}


resource "aws_instance" "web" {
  #   count             = 2
  for_each          = toset(data.aws_ec2_instance_type_offerings.example.locations)
  availability_zone = each.key
  ami               = data.aws_ssm_parameter.my-amzn-linux-ami.value
  instance_type     = var.instance_type
  #   instance_type          = var.instance_type_map["prod"]
  vpc_security_group_ids = [aws_security_group.allow_http.id, aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.sshkey.key_name
  #   user_data              = file("${path.module}/httpd.sh")
  tags = {
    "Name" = "EC2-Terraform-${each.key}"
  }
}
