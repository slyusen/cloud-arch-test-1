import logging
import boto3
from botocore.exceptions import ClientError
import os

s3_client = boto3.client("s3")
ecs_client = boto3.client("ecs")


def upload_file(file_name, bucket=None, object_name=None):
    # If S3 object_name was not specified, use file_name
    if object_name is None:
        object_name = os.path.basename(file_name)

    if bucket == None:
        bucket = os.environ["BUCKET_NAME"]

    try:
        response = s3_client.upload_file(file_name, bucket, object_name)
    except ClientError as e:
        logging.error(e)
        return False
    return True


def list_objects(bucket):
    if bucket == None:
        bucket = os.environ["BUCKET_NAME"]
    response = ""
    try:
        response = s3_client.list_objects(Bucket=bucket)
        if len(response["Contents"]) > 0:
            for cnt in response["Contents"]:
                print(cnt["Key"])
                #print("\n")
    except ClientError as e:
        logging.error(e)
        return False
    #print(response)


def list_task_def_versions(task_family):
    if task_family == None:
        task_family = os.environ["TASK_FAMILY"]

    response = ecs_client.list_task_definitions(familyPrefix=task_family)
    print(response["taskDefinitionArns"])



if __name__ == '__main__':
    # upload_file(file_name="file_1.txt")
    # upload_file(file_name="file_2.txt")
    # print("Hello")
    input_val = input("1. Choose to list s3 files!! \n 2. Choose to list versions of ecs task definitions \n")
    if input_val == "1":
        bucket_name = input("Enter bucket name: \n")
        list_objects(bucket=bucket_name)
    else:
        task_family = input("Enter task family name \n")
        list_task_def_versions(task_family=task_family)
