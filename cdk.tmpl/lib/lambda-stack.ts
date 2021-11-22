import * as cdk from '@aws-cdk/core'
import * as lambda from '@aws-cdk/aws-lambda'

export class LambdaStack extends cdk.Stack {

  public readonly lambda: lambda.Function

  constructor(parent: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(parent, id, props)

    // FunctionProps: https://docs.aws.amazon.com/cdk/api/latest/python/aws_cdk.aws_lambda/FunctionProps.html
    // StackProps : https://docs.aws.amazon.com/cdk/api/latest/python/aws_cdk.core/StackProps.html
    const lambdaProps: lambda.FunctionProps & cdk.StackProps = {
      env: {
        region: process.env.AWS_REGION
      },
      runtime: lambda.Runtime.NODEJS_14_X,
      functionName: process.env.PROJECT_NAME,
      code: lambda.Code.fromAsset(`${process.env.PROJECT_DIR}/lambda/`),
      handler: 'index.handler',
      environment: {
        TABLE_NAME: process.env.PROJECT_NAME as string,
      },
    }
    // console.log(lambdaProps)

    this.lambda = new lambda.Function(this, 'Lambda', lambdaProps)
  }
}
