'use strict';

var accountSid = 'AC00d0daf67c10a7cce79efbdb2941f429';
var authToken = '318a494e0195ca17210703ca940d8b22';
var twilio = require('twilio');
var client = new twilio.RestClient(accountSid, authToken);
var dynamo = require('../shared/dynamoDocHelper');

module.exports.handler = function(event, context) {
  //TODO: parse most recent items, add changes to text. Limit text to 1/day
  var params = {
    TableName: 'kdm-numbers'
  };
  return dynamo.scanAsync(params).then(function(data) {
    data.Items.forEach(function(n) {
      client.messages.create({
        body: 'KDM Store Update - https://www.lanternhoard.com/storewatch',
        to: n.mobile,
        from: '+15719913883'
      }, function(err, message) {
        console.log(err);
        console.log(message);
      });
    });
  });
};
