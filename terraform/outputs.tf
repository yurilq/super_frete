output "s3_bucket_name" {
  value = aws_s3_bucket.bucket_dados_superfrete.bucket
}

output "emr_cluster_id" {
  value = aws_emr_cluster.cluster_emr_superfrete.id
}

output "rds_endpoint" {
  value = aws_db_instance.rds_superfrete.endpoint
}

output "redshift_endpoint" {
  value = aws_redshift_cluster.redshift_cluster_superfrete.endpoint
}
