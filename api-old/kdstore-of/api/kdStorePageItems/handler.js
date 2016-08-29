'use strict';

const dynamo = require('../shared/dynamoDocHelper');
const db = require('../shared/dynamoHelper');
const msgpack = require('msgpack');
const _ = require('lodash');

module.exports.handler = function(event, context, cb) {
  let count = event.count;
  let fromDate = event.fromDate;
  let direction = event.direction === 'forward' ? true : false;
  let expr;
  if (direction) {
    expr = "#status = :ok and #Date > :date";
  } else {
    expr = "#status = :ok and #Date < :date";
  }
  let params = {
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
    let buildResult = {};
    buildResult.items = _.map(data.Items, function(item) {
      item = {
        items: msgpack.unpack(item.data.B),
        date: parseInt(item.entryDate.N)
      };
      return item;
    });
    let checkExpr = "#status = :ok and #Date < :date";
    if (data.LastEvaluatedKey)
    {
      let fromDate = data.LastEvaluatedKey.orderDate.N;
      let checkParams = {
        TableName: 'kdm-entries',
        IndexName: 'status-orderDate-index',
        KeyConditionExpression: checkExpr,
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
        ScanIndexForward: false,
        Limit: 1
      };
      return db.queryAsync(checkParams).then(function(data) {
        if (data.Count > 0)
        {
          buildResult.hasMore = true;
        }
        else
        {
          buildResult.hasMore = false;
        }
        context.succeed(buildResult);
      });
    }
    else
    {
      buildResult.hasMore = false;
      context.succeed(buildResult);
    }
  })
    .catch(function(err) {
      console.log(err);
      context.fail(JSON.stringify({
        errorMessage: 'GETERROR'
      }));
    });
};
