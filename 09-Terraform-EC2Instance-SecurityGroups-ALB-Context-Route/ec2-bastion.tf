resource "aws_instance" "bastion" {
  ami           = data.aws_ssm_parameter.ami.value
  instance_type = var.instance_type
  subnet_id     = aws_subnet.pub2.id
  tags = {
    Name = "${var.bastion_instance_name}"
  }
  security_groups = [aws_security_group.bastion.id]
  key_name        = aws_key_pair.sshkey.key_name
  provisioner "file" {
    source      = "/home/ashik/.ssh/terraform"
    destination = "/home/ec2-user/.ssh/id_rsa"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.bastion.public_ip
      private_key = file("~/.ssh/terraform")
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.bastion.public_ip
      private_key = file("~/.ssh/terraform")
    }
    # command = "chmod 400 ~/.ssh/terraform"
    inline = ["chmod 400 /home/ec2-user/.ssh/id_rsa"]
    # depends_on = [provisioner.file]
  }

}
