'use strict';

var request = require('request');
var cheerio = require('cheerio');
var dynamo = require('../shared/dynamoDocHelper');
var db = require('../shared/dynamoHelper');
var msgpack = require('msgpack');

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
    context.succeed(true);
  }).catch(function(err, msg) {
    return context.fail(JSON.stringify({
      errorMessage: 'DuplicateTimestamp'
    }));
  });
}

module.exports.handler = function(event, context) {
  request('http://shop.kingdomdeath.com/collections/in-stock', function(error, res, body) {
    if (!error) {
      var $ = cheerio.load(body);
      var q = {
        date: Date.now(),
        items: $('.product').map(function(i, el) {
          var _this = $(this);
          var obj = {
            title: _this.find('.title').text().trim(),
            link: _this.find('.details a').attr('href').trim()
          };
          var price = _this.find('.price');
          if (price.find('del').length > 0) {
            var prices = price.text().match(/\$\d+/g);
            if (prices) {
              if (prices.length === 1) {
                obj.price = prices[0];
              } else {
                obj.price = prices[1];
                obj.oldPrice = prices[0];
              }
            } else {
              obj.price = price.text().trim();
            }
          } else {
            obj.price = price.text().trim();
          }
          return obj;
        }).get()
      };
      if (q.items.length <= 0) {
        return context.done(null, {
          message: 'No Items'
        });
      } else {
        var params = {
          TableName: 'kdm-entries',
          Limit: 1,
          IndexName: 'status-orderDate-index',
          KeyConditionExpression: "#status = :ok",
          ExpressionAttributeNames: {
            "#status": "status"
          },
          ExpressionAttributeValues: {
            ":ok": { "S": "OK" }
          },
          ScanIndexForward: false
        };
        return db.queryAsync(params).then(function(data) {
          console.log(data);
          var orig = data.Items[0];
          if (msgpack.pack(q.items).toString() == orig.data.B.toString()) {
            return context.done(null, {
              message: 'No change'
            });
          } else {
            createObject(q, context);
          }
        })
          .catch(function(err) {
            console.log(err);
            console.log('nada');
            createObject(q, context);
          });
      }
    }
  }, function() {
    return context.done(null, {
      message: 'Kingdom death, shouldnt get here'
    });
  });
};
