var fs = require('fs');
var app = require('http').createServer(function(req, res) {
	res.writeHead(200, {'Content-Type': 'text/html'});
	res.write("<h1>プロセス 3002</h1>");
	res.end(fs.readFileSync('index.html'));
}).listen(3002);

var io = require('socket.io').listen(app);
var redis = require('socket.io-redis');
io.adapter(redis({ host: 'localhost', port: 6379 }));

io.sockets.on('connection', function(socket) {
	socket.on('msg', function(data) {
		io.sockets.emit('msg', data);
		console.log('receive:', data);
	});
});
