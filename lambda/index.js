const AWS = require('aws-sdk')

const dynamodb = new AWS.DynamoDB()
const { unmarshall } = AWS.DynamoDB.Converter

exports.handler = async (event) => {

    // return buildResponse(200, event)

    var response
    
    if (event.httpMethod == 'GET' && event.path == '/') {
        response = list()
    } else if (event.httpMethod == 'POST' && event.path == '/add') {
        response = add(JSON.parse(event.body).value)
    } else {
        response = buildResponse(200, 'nothing')
    }

    return response 
}

function buildResponse(statusCode, body) {
    return {
        statusCode,
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(body)
    }
}

async function list() {
    const params = {
        TableName: process.env.TABLE_NAME,
    }
    
    return await dynamodb.scan(params).promise()
        .then(response => {
            return buildResponse(200, response.Items.map(e => unmarshall(e)))
        }, error => {
            console.error(error)
            return buildResponse(400, error)
        })
}

// random id with also uppercase [a-zA-Z0-9] like 0UewFo2IME
function uid() {
    return Math.random().toString(36)
        .substring(2, 12)
        .split('')
        .map(e=> Math.random() > Math.random() ? e : e.toUpperCase())
        .join('')
}

async function add(value) {

    const params = {
        TableName: process.env.TABLE_NAME,
        Item: {
            Id: { S: uid() },
            Date: { N: Date.now().toString() },
            Value: { S: value }
        }
    }

    return await dynamodb.putItem(params).promise()
        .then(() => {
            return buildResponse(200, { Operation: 'putItem', Item: params.Item })
        }, error => {
            console.error(error)
            return buildResponse(400, error)
        })
}