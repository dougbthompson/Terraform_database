provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

variable "scp_command_mssql" {
  type = "list"
  default = [ "scp -o StrictHostKeyChecking=no ",
              "-i /home/dthompson/aws/db_ec2_ohio_01.pem ",
              "/opt/terraform/g/install_mssql.sh ubuntu@",
              ":/tmp" ]
}
variable "scp_command_galera" {
  type = "list"
  default = [ "scp -o StrictHostKeyChecking=no ",
              "-i /home/dthompson/aws/db_ec2_ohio_01.pem ",
              "/opt/terraform/g/install_galera.sh ubuntu@",
              ":/tmp" ]
}
variable "scp_command_postgres" {
  type = "list"
  default = [ "scp -o StrictHostKeyChecking=no ",
              "-i /home/dthompson/aws/db_ec2_ohio_01.pem ",
              "/opt/terraform/g/install_postgres.sh ubuntu@",
              ":/tmp" ]
}

resource "null_resource" "run_scp_mssql" {
  triggers {
    run_scp_mssql = "${uuid()}"
  }

  count = "${length("${var.public_ips}")}"
  connection {
    user        = "ubuntu"
    private_key = "${file("${var.pem_file}")}"
    host        = "${element("${var.public_ips}", count.index)}"
  }

  provisioner "local-exec" {
    command = "echo $A$B$C$D$E > /tmp/script_ms_$F.sh; chmod 755 /tmp/script_ms_$F.sh; /tmp/script_ms_$F.sh"

    environment {
      A = "${element("${var.scp_command_mssql}", 0)}"
      B = "${element("${var.scp_command_mssql}", 1)}"
      C = "${element("${var.scp_command_mssql}", 2)}"
      D = "${element("${var.public_ips}", count.index)}"
      E = "${element("${var.scp_command_mssql}", 3)}"
      F = "${count.index}"
    }
  }

  # where the actual remote script should be run from...
  provisioner "remote-exec" {
    inline = [
      "sudo timedatectl set-timezone America/Los_Angeles",
    ]
  }
}

resource "null_resource" "run_scp_galera" {
  triggers {
    run_scp_galera = "${uuid()}"
  }

  count = "${length("${var.public_ips}")}"
  connection {
    user        = "ubuntu"
    private_key = "${file("${var.pem_file}")}"
    host        = "${element("${var.public_ips}", count.index)}"
  }

  provisioner "local-exec" {
    command = "echo $A$B$C$D$E > /tmp/script_ga_$F.sh; chmod 755 /tmp/script_ga_$F.sh; /tmp/script_ga_$F.sh"

    environment {
      A = "${element("${var.scp_command_galera}", 0)}"
      B = "${element("${var.scp_command_galera}", 1)}"
      C = "${element("${var.scp_command_galera}", 2)}"
      D = "${element("${var.public_ips}", count.index)}"
      E = "${element("${var.scp_command_galera}", 3)}"
      F = "${count.index}"
    }
  }
}

resource "null_resource" "run_scp_postgres" {
  triggers {
    run_scp_postgres = "${uuid()}"
  }

  count = "${length("${var.public_ips}")}"
  connection {
    user        = "ubuntu"
    private_key = "${file("${var.pem_file}")}"
    host        = "${element("${var.public_ips}", count.index)}"
  }

  provisioner "local-exec" {
    command = "echo $A$B$C$D$E > /tmp/script_pg_$F.sh; chmod 755 /tmp/script_pg_$F.sh; /tmp/script_pg_$F.sh"

    environment {
      A = "${element("${var.scp_command_postgres}", 0)}"
      B = "${element("${var.scp_command_postgres}", 1)}"
      C = "${element("${var.scp_command_postgres}", 2)}"
      D = "${element("${var.public_ips}", count.index)}"
      E = "${element("${var.scp_command_postgres}", 3)}"
      F = "${count.index}"
    }
  }
}

# scp -o StrictHostKeyChecking=no -i /home/dthompson/aws/db_ec2_ohio_01.pem /opt/terraform/g/install_postgres.sh ubuntu@18.223.108.42:/tmp

