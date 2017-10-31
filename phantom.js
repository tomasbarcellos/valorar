var system = require('system');
var webPage = require('webpage');
var fs = require('fs');

var args = system.args;
var page = webPage.create();

page.open(args[1], function (status) {
  var content = page.content;
  fs.write(args[2], content, 'w');
  phantom.exit();
});
