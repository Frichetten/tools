parseJwt = function(token) {
  var base64Url = token.split('.')[1];
  var base64 = base64Url.replace('-', '+').replace('_', '/');
  var buf = new Buffer(base64, 'base64');
  return JSON.parse(buf);
}

var decoded = parseJwt(process.argv[2]);

console.log(decoded);
