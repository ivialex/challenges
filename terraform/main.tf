resource "null_resource" "minikube" {
  # change trigger to run every time
  triggers = {
    build_number = "${timestamp()}"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/minikube"
    command = "chmod +x install-minikube.sh"
  }

  # minikube install
  provisioner "local-exec" {
    command = "install-minikube.sh install"
    working_dir = "${path.module}/minikube"
  }

  # minikube start
  provisioner "local-exec" {
    command = "install-minikube.sh start"
    working_dir = "${path.module}/minikube"
  }

  # minikube status
  provisioner "local-exec" {
    command = "install-minikube.sh status"
    working_dir = "${path.module}/minikube"
  }

}

resource "null_resource" "kubectl" {
  triggers = {
    build_number = "${timestamp()}"
  }

  provisioner "local-exec" {
    working_dir = "../kubernetes/deploy/"
    command = "deployment.sh"
  }

}
