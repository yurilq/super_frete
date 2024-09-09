from airflow import DAG
from airflow.providers.amazon.aws.operators.emr_create_job_flow import EmrCreateJobFlowOperator
from datetime import datetime

with DAG('processamento_dados', start_date=datetime(2024, 9, 1), schedule_interval='@daily') as dag:
    processar = EmrCreateJobFlowOperator(
        task_id='processar_dados',
        job_flow_overrides={
            # Configurações do EMR para processamento com Spark
        },
        aws_conn_id='aws_default'
    )
    
    processar
