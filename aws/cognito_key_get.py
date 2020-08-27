#!/usr/bin/env python3
# Source: https://andresriancho.com/wp-content/uploads/2019/06/whitepaper-internet-scale-analysis-of-aws-cognito-security.pdf
import boto3
import sys

def get_pool_credentials(identity_pool):
    client = boto3.client('cognito-identity')
    _id = client.get_id(IdentityPoolId=identity_pool)
    _id = _id['IdentityId']
    credentials = client.get_credentials_for_identity(IdentityId=_id)
    access_key = credentials['Credentials']['AccessKeyId']
    secret_key = credentials['Credentials']['SecretKey']
    session_token = credentials['Credentials']['SessionToken']
    identity_id = credentials['IdentityId']
    print(access_key, secret_key, session_token, identity_id)

get_pool_credentials(sys.argv[1])
