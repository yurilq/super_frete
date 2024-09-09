variable "aws_region" {
  description = "Região da AWS"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket S3 para armazenar dados brutos"
  default     = "superfrete-dados-brutos"
}

variable "emr_version" {
  description = "Versão do EMR"
  default     = "emr-6.3.0"
}

variable "instance_type" {
  description = "Tipo de instância EC2 para o EMR"
  default     = "m5.xlarge"
}

variable "rds_instance_type" {
  description = "Tipo de instância para o banco de dados RDS"
  default     = "db.t3.medium"
}

variable "rds_database_name" {
  description = "Nome do banco de dados RDS"
  default     = "superfrete_banco"
}

variable "redshift_node_type" {
  description = "Tipo de nó para o cluster Redshift"
  default     = "dc2.large"
}
