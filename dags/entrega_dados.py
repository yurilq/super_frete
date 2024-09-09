from airflow import DAG
from airflow.providers.amazon.aws.operators.redshift_sql import RedshiftSQLOperator
from datetime import datetime

with DAG('entrega_dados', start_date=datetime(2024, 9, 1), schedule_interval='@daily') as dag:
    inserir_redshift = RedshiftSQLOperator(
        task_id='inserir_redshift',
        sql='INSERT INTO tabela_destino SELECT * FROM tabela_temporaria',
        aws_conn_id='aws_default'
    )
    
    inserir_redshift
