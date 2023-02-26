provider "aws" {
    region= "us-east-1"
}

#CREACION DE UN SECURITY GROUP: En este caso, para la conexion por ssh a la instancia
resource "aws_security_group" "ssh_connection" {
  name        = var.sg_name
  description = "Allow SSH and TCP (port 80) connection by our localhost"

  #Uso de dynamic, herramienta para iterrar sobre un bloque, en ese caso sera para el bloque
  #"ingress" y poder crear varias reglas de ingreso en un solo bloque.
  dynamic "ingress" { 
    #For_each: permite la iteracion por elemento estipulado en el bloque de content
    for_each = var.ingress_rules 
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = {
    Name = "allow_tls"
  }
}

# CREACION DE UNA INSTANCIA 
resource "aws_instance" "platzi-instance" {
    #Declaracion, para la declaracion se puede usar especificar tal cual el valor
    #como aprece abajo con "ami", pero eso no es parametrizable o escalable, para
    #ello esta la posibilidad de usar variables, con var.varName y archivos de declaracion. 
    #ami = "ami-064ad157c14f7f51a"
    
    #Uso de Variables en Terraform
    ami = var.ami_id                    #Basta con usar var."anyName"
    instance_type = var.instance_type   #Con la posibilidad de escoger entre diferentes tipos de dato:
    tags = var.tags                     #a) string      b) map      c) list
    security_groups = ["${aws_security_group.ssh_connection.name}"] #Decleacion del recurso security_group

    #Ahora, solo se esta haciendo uso de estas variables, pero no se estan declarando y dando un valor
    #para su declaracion vamos a ver arriba, ahi estan declaradas pero no asignadas. PAra su declaracion, 
    #se usara un archivo llamado variables.tf donde solo esta la declaracion y descripcion. Para la 
    #asignacion a un valor en concreto se usara otro arvhivo, dev.tfvars, donde solo van los valores a usar.
    #Esto pemrite ser escalable y parametrizable :D.

}