'use strict';
var querystring = require('querystring');
var db = require('../shared/dynamoHelper');

module.exports.handler = function(event, context, cb) {
  var parsedparams = querystring.parse(event.postBody);
  var from = parsedparams.From;
  var message = parsedparams.Body;
  if (message === 'KDMSTOP') {
    var params = {};
    var key = {
      "mobile": {
        "S": from
      }
    };
    params.TableName = 'kdm-numbers';
    params.ConditionExpression = "attribute_exists(mobile)";
    params.Key = key;
    return db.deleteItemAsync(params)
      .then(function(res, err) {
        context.succeed('Thank you! You will no longer recieve texts regarding the Kingdom Death Store.');
      }).catch(function(err) {
      console.log(err);
      if (err.code === 'ConditionalCheckFailedException') {
        context.succeed('Your number was not subscribed to recieve texts regarding Kingdom Death updates.');
      } else {
        context.succeed('Sorry, there was a problem removing your number. Please try again!');
      }
    });
  }
};
