#Archivo de Declaracion de las variblaes na usar. 

variable "ami_id" {
    default = ""
    description = "Declaracion de la ami a usar"
}

variable "instance_type" {
  
}

variable "tags" {
  
}

variable "sg_name" {
  
}

variable "ingress_rules" {
  
}

#ahora toca ir a otro archivo (dev.tfvars) donde ahi se le 
#dara un valor(es) a las variables declaradas. 