'use strict';

var dynamo = require('../shared/dynamoDocHelper');
var db = require('../shared/dynamoHelper');
var msgpack = require('msgpack');
var _ = require('lodash');

module.exports.handler = function(event, context, cb) {
  var count = event.count;
  var fromDate = event.fromDate;
  var direction = event.direction === 'forward' ? true : false;
  var expr;
  if (direction) {
    expr = "#status = :ok and #Date > :date";
  } else {
    expr = "#status = :ok and #Date < :date";
  }
  var params = {
    TableName: 'kdm-entries',
    IndexName: 'status-orderDate-index',
    KeyConditionExpression: expr,
    ExpressionAttributeNames: {
      "#status": "status",
      "#Date": "orderDate"
    },
    ExpressionAttributeValues: {
      ":ok": {
        "S": "OK"
      },
      ":date": {
        "N": fromDate
      }
    },
    ScanIndexForward: direction,
    Limit: event.count || 10
  };
  return db.queryAsync(params).then(function(data) {
    var items = _.map(data.Items, function(item) {
      item = {
        items: msgpack.unpack(item.data.B),
        date: parseInt(item.entryDate.N)
      };
      return item;
    });
    context.succeed(items);
  })
    .catch(function(err) {
      console.log(err);
      context.fail(JSON.stringify({
        errorMessage: 'GETERROR'
      }));
    });
  return cb(null, {
    message: 'Go Serverless! Your Lambda function executed successfully!'
  });
};
