"use strict";

const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient();

const tableName = process.env.DYNAMODB_TABLE_NAME;

const params = {
  TableName: tableName
}

async function listItems() {
  try {
    const data = await docClient.scan(params).promise()
    return data
  } catch (err) {
    return err
  }
}

exports.handler = async function handler(_event, _context) {
  try {
    const data = await listItems()

    let ret = {};
    ret = {
      'statusCode': 200,
      'statusDescription': '200 OK',
      'headers': {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin" : "*",
        "Access-Control-Allow-Credentials" : "true"
      },
      'body': JSON.stringify(data)
    }
    ret.code = 200;
    return ret;
  } catch (err) {
    let ret = {};
    ret = {
      'statusCode': 500,
      'statusDescription': '500 Error'
    }
    ret.code = 500;
    return ret;
  }
}
