# S3 Bucket
resource "aws_s3_bucket" "bucket_dados_superfrete" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    noncurrent_version_expiration {
      days = 30
    }
  }
}

# EMR Cluster
resource "aws_emr_cluster" "cluster_emr_superfrete" {
  name          = "superfrete-emr-cluster"
  release_label = var.emr_version
  applications  = ["Hadoop", "Spark"]
  service_role  = aws_iam_role.emr_service_role.arn
  ec2_attributes {
    instance_profile = aws_iam_instance_profile.emr_instance_profile.arn
  }
  master_instance_type = var.instance_type
  core_instance_count  = 2
  core_instance_type   = var.instance_type
  log_uri              = "s3://${aws_s3_bucket.bucket_dados_superfrete.bucket}/logs/emr/"
  
  bootstrap_action {
    name  = "Bootstrap action"
    path  = "s3://superfrete-dados-brutos/scripts/bootstrap.sh"
  }
}

# RDS PostgreSQL
resource "aws_db_instance" "rds_superfrete" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13.3"
  instance_class       = var.rds_instance_type
  name                 = var.rds_database_name
  username             = "admin"
  password             = "senha-superfrete"
  publicly_accessible  = false
  skip_final_snapshot  = true
}

# Redshift Cluster
resource "aws_redshift_cluster" "redshift_cluster_superfrete" {
  cluster_identifier      = "superfrete-redshift-cluster"
  node_type               = var.redshift_node_type
  number_of_nodes         = 2
  database_name           = var.rds_database_name
  master_username         = "admin"
  master_password         = "senha-superfrete"
  publicly_accessible     = false
}

# Security Group
resource "aws_security_group" "sg_superfrete" {
  name        = "sg-superfrete"
  description = "Segurança para pipeline Super Frete"
  vpc_id      = "vpc-id"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
