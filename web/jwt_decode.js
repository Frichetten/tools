parseJwt = function(token, section) {
  var header = token.split('.')[section];
  var base64 = header.replace('-', '+').replace('_', '/');
  var buf = new Buffer(base64, 'base64');
  return JSON.parse(buf);
}

var header = parseJwt(process.argv[2], 0);
var body = parseJwt(process.argv[2], 1);

console.log(header);
console.log(body);
console.log(process.argv[2].split('.')[2]);
