from airflow import DAG
from airflow.providers.amazon.aws.transfers.s3_to_local import S3UploadOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime

def extrair_dados():
    # Função para extrair dados de fontes externas (API ou batch)
    pass

with DAG('ingestao_dados', start_date=datetime(2024, 9, 1), schedule_interval='@daily') as dag:
    extrair = PythonOperator(
        task_id='extrair_dados',
        python_callable=extrair_dados
    )
    
    enviar_s3 = S3UploadOperator(
        task_id='enviar_dados_s3',
        aws_conn_id='aws_default',
        s3_bucket='superfrete-dados-brutos',
        s3_key='raw_data/'
    )
    
    extrair >> enviar_s3
