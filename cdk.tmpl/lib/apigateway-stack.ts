import * as cdk from '@aws-cdk/core'
import * as apigw from '@aws-cdk/aws-apigateway'

export class ApiGatewayStack extends cdk.Stack {

  public readonly api: apigw.LambdaRestApi

  constructor(scope: cdk.Construct, id: string, props: apigw.LambdaRestApiProps) {
    super(scope, id, props)

    // LambdaRestApiProps : https://docs.aws.amazon.com/cdk/api/latest/python/aws_cdk.aws_apigateway/LambdaRestApiProps.html
    var apiProps: apigw.LambdaRestApiProps = {
      handler: props.handler,
      restApiName: process.env.PROJECT_NAME,
      defaultCorsPreflightOptions: {
        allowOrigins: ['*'],
        allowCredentials: true,
      },
      endpointTypes: [apigw.EndpointType.REGIONAL],
    }

    this.api = new apigw.LambdaRestApi(this, 'ApiGateway', apiProps)

    // CfnOutputProps : https://docs.aws.amazon.com/cdk/api/latest/python/aws_cdk.core/CfnOutputProps.html
    var outputProps: cdk.CfnOutputProps = {
      value: this.api.url,
      description: 'The apigateway URL',
      exportName: 'apigateway-url',
    }

    new cdk.CfnOutput(this, 'Url', outputProps)
  }
}
