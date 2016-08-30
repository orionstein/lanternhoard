var aws = require('aws-sdk');
var bluebird = require('bluebird');

var lm = new aws.Lambda(
  {
    region: 'us-east-1',
  });

var promiseLambda = bluebird.promisifyAll(lm);

module.exports = promiseLambda;

