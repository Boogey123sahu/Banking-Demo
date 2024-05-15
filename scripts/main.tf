resource "aws_instance" "test-server" {
  ami           = "ami-0bb84b8ffd87024d8" 
  instance_type = "t2.micro" 
  key_name = "19_Apr"
  vpc_security_group_ids= ["sg-0fe5ca62f63896cb9"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./19_Apr.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/BankingProject/scripts/finance-playbook1.yml "
  } 
}
