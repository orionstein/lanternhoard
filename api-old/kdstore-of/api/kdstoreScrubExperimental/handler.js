'use strict';

var s3 = require('../shared/s3Helper');
var cheerio = require('cheerio');
var kd = require('../shared/kdmpull.node');
var db = require('../shared/dynamoHelper');

function createObject(body, context) {
  s3.putObjectAsync({
    'Bucket': 'kingdomdeath',
    'Key': 'kingdomdeathstore.json',
    'Body': JSON.stringify(body),
    'ContentType': 'application/json',
    'ACL': 'public-read'
  }).then(function(err, res) {
    return context.done(null, {
      message: 'Success',
      data: res
    });
  })
    .catch(function(error) {
      return context.done(null, {
        message: error
      });
    });
}

function compareObject(body, context) {
}

module.exports.handler = function(event, context) {
  let body = kd.get();
  if (body) {

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
      console.log(q.items);
      s3.getObjectAsync({
        'Bucket': 'kingdomdeath',
        'Key': 'kingdomdeathstore.json'
      }, function(err, res) {
        if (!err) {
          var obj = JSON.parse(res.Body);
          if (JSON.stringify(q.items) === JSON.stringify(obj[0].items)) {
            return context.done(null, {
              message: 'No change'
            });
          } else {
            var newObj = [q].concat(obj);
            createObject(newObj, context);
          }
        } else {
          createObject([q], context);
        }
      })
        .catch(function(error) {
          return context.done(null, {
            message: error
          });
        });
    }
  }
};
