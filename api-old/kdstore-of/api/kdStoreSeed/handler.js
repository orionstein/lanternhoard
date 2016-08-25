'use strict';
var dynamo = require('../shared/dynamoDocHelper');
var db = require('../shared/dynamoHelper');
var msgpack = require('msgpack');
var s3 = require('../shared/s3Helper');
var _ = require('lodash');

function createObject(obj, context) {
  var compressed = msgpack.pack(obj.items);
  var params = {
    TableName: 'kdm-entries',
    "Item": {
      "entryDate": {
        "N": obj.date.toString()
      },
      "orderDate": {
        "N": obj.date.toString()
      },
      "data": {
        "B": compressed
      },
      "status": {
        "S": "OK"
      }
    }
  };
  return db.putItemAsync(params).then(function(data) {
    //context.succeed(true);
    console.log('added');
  }).catch(function(err, msg) {
    console.log('failed');
//     return context.fail(JSON.stringify({
//       errorMessage: 'DuplicateTimestamp'
//     }));
  });
}

module.exports.handler = function(event, context, cb) {
  s3.getObjectAsync({
    'Bucket': 'kingdomdeath',
    'Key': 'kingdomdeathstore.json'
  }, function(err, res) {
    if (!err) {
      var obj = JSON.parse(res.Body);
      _.map(obj, function(item){
        createObject(item);
      });
    }
  });
};
