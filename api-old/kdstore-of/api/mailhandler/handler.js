var AWS = require('aws-sdk');
var s3 = new AWS.S3();

var bucketName = 'email.orionfree.com';

exports.handler = function(event, context, callback) {
  console.log('Process email');

  var sesNotification = event.Records[0].ses;
  console.log("SES Notification:\n", JSON.stringify(sesNotification, null, 2));

  // Retrieve the email from your bucket
  s3.getObject({
    Bucket: bucketName,
    Key: sesNotification.mail.messageId
  }, function(err, data) {
    if (err) {
      console.log(err, err.stack);
      callback(err);
    } else {
      console.log("Raw email:\n" + data.Body);
      console.log(data);

      var matches = /\n--[^\n\r]*\r?\nContent-Type: text\/plain[\s\S]*?\r?\n\r?\n([\s\S]*?)\n\r?\n--/gim.exec(data.Body);
      console.log(matches);
      console.log(matches[0]);
      var sns = new AWS.SNS();
      var params = {
        Message: matches[0].toString(),
        Subject: "Email from " + sesNotification.mail.source + " to " + sesNotification.mail.destination.toString() + " : " + sesNotification.mail.commonHeaders.subject.toString(),
        TopicArn: "arn:aws:sns:us-east-1:556993035688:OFNetwork"
      };
      sns.publish(params, context.done);

      callback(null, null);
    }
  });
};
