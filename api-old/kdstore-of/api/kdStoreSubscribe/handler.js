'use strict';

var accountSid = 'AC00d0daf67c10a7cce79efbdb2941f429';
var authToken = '318a494e0195ca17210703ca940d8b22';
var twilio = require('twilio');
var client = new twilio.RestClient(accountSid, authToken);
var dynamo = require('../shared/dynamoDocHelper');
var db = require('../shared/dynamoHelper');

module.exports.handler = function(event, context) {
  var number = event.number;
  if (number.indexOf("+") < 0) {
    number = "+1" + number;
  }
  var params = {
    TableName: 'kdm-numbers',
    "ConditionExpression": "attribute_not_exists(mobile)",
    "Item": {
      "mobile": {
        "S": number
      }
    }
  };
  return db.putItemAsync(params).then(function(data) {
    client.messages.create({
      body: 'Thank you for subscribing to KDM Updates! You can cancel at any time by texting KDMSTOP to +15719913883',
      to: number,
      from: '+15719913883'
    }, function(err, message) {
      console.log(err);
      console.log(message);
      context.succeed(true);
    });
  }).catch(function(err, msg) {
    return context.fail(JSON.stringify({
      errorMessage: 'DuplicateNumber'
    }));
  });
};
