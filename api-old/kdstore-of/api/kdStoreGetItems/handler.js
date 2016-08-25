'use strict';

var dynamo = require('../shared/dynamoDocHelper');
var db = require('../shared/dynamoHelper');
var msgpack = require('msgpack');
var _ = require('lodash');

module.exports.handler = function(event, context, cb) {
  var params = {
    TableName: 'kdm-entries',
    IndexName: 'status-orderDate-index',
    KeyConditionExpression: "#status = :ok",
    ExpressionAttributeNames: {
      "#status": "status"
    },
    ExpressionAttributeValues: {
      ":ok": {
        "S": "OK"
      }
    },
    ScanIndexForward: false,
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
      context.fail(JSON.stringify({
        errorMessage: 'GETERROR'
      }));
    });
};
