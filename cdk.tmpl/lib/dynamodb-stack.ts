import * as cdk from '@aws-cdk/core'
import * as dynamodb from '@aws-cdk/aws-dynamodb'

export class DynamoDbStack extends cdk.Stack {

  public readonly table: dynamodb.Table
  
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props)

    // TableProps : https://docs.aws.amazon.com/cdk/api/latest/python/aws_cdk.aws_dynamodb/TableProps.html
    // StackProps : https://docs.aws.amazon.com/cdk/api/latest/python/aws_cdk.core/StackProps.html
    const tableProps: dynamodb.TableProps & cdk.StackProps = {
      env: {
        region: process.env.AWS_REGION
      },
      tableName: process.env.PROJECT_NAME,
      partitionKey: {
        name: 'Id',
        type: dynamodb.AttributeType.STRING
      },
      sortKey: {
        name: 'Date', 
        type: dynamodb.AttributeType.NUMBER
      },
      readCapacity: 1,
      writeCapacity: 1,
      // delete table when `cdk destroy`
      removalPolicy: cdk.RemovalPolicy.DESTROY,
    }
    // console.log(tableProps)

    this.table = new dynamodb.Table(this, 'Table', tableProps)
  }
}
