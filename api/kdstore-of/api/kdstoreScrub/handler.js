'use strict';

var s3 = require('../shared/s3Helper');
var request = require('request');
var cheerio = require('cheerio');

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

module.exports.handler = function(event, context) {
  request('http://shop.kingdomdeath.com/collections/in-stock', function(error, res, body) {
    if (!error) {

      var $ = cheerio.load(body);

      var q = {
        date: Date.now(),
        items: $('.product').map(function(i, el) {
          var _this = $(this);
          return {
            title: _this.find('.title').text().trim(),
            price: _this.find('.price').text().trim(),
            link: _this.find('.details a').attr('href').trim()
          };
        }).get()
      };

      if (q.items.length <= 0) {
        return context.done(null, {
          message: 'No Items'
        });
      } else {
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
  }, function() {
    return context.done(null, {
      message: 'Kingdom death, shouldnt get here'
    });
  });
};
