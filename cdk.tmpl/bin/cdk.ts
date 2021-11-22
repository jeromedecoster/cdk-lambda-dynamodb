#!/usr/bin/env node
import 'source-map-support/register'
import * as cdk from '@aws-cdk/core'

import { LambdaStack } from '../lib/lambda-stack'
import { ApiGatewayStack } from '../lib/apigateway-stack'
import { DynamoDbStack } from '../lib/dynamodb-stack'

const app = new cdk.App()

const AWS_REGION = process.env.AWS_REGION
const TABLE_NAME = process.env.PROJECT_NAME

console.log('AWS_REGION', AWS_REGION)
console.log('TABLE_NAME', TABLE_NAME)

const { lambda } = new LambdaStack(app, 'Lambda')

new ApiGatewayStack(app, 'ApiGateway', { handler: lambda })

const { table } = new DynamoDbStack(app, 'DynamoDB')

table.grantReadWriteData(lambda)