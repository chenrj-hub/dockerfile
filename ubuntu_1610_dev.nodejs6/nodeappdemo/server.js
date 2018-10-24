var fs = require('fs');
var express = require('express'),
    app = express(),
    redis = require('redis'),
    RedisStore = require('connect-redis')(express),
    yaml = require('js-yaml'),
    path = require('path'),
    server = require('http').createServer(app);

process.env.NODE_ENV = process.argv[2] || process.env.NODE_ENV || 'local';

var config = yaml.safeLoad(fs.readFileSync(path.join(__dirname, 'environment-' + process.env.NODE_ENV + '.yml'), 'utf8'));
var app_config = config.app;
var redis_config = config.redis;

var redisSessionStore = new RedisStore({
    host: redis_config.redis_host,
    port: redis_config.redis_port || 6379,
    db: redis_config.redis_db || 0,
    pass: redis_config.redis_pass
});

var redisClient = redis.createClient(redis_config.redis_port || 6379,redis_config.redis_host,{});  


redisClient.auth(redis_config.redis_pass, function(err) {
	if (err) console.log("Redis Auth Error: " + err);
});  

redisClient.select(redis_config.redis_db, function(err) { 
	if (err) console.log("Redis Select DB Error: " + err);
}); 

redisClient.on("error", function (err) {  
	if (err) console.log("Redis Client Occure Error: " + err);  
});  

redisClient.set("string key", "string val", function(err) { 
	if (err) console.log("Redis Set Key Error: " + err);
});


app.configure(function() {
  app.use(express.logger({stream: fs.createWriteStream('/var/log/nodejs/app.log', {flags: 'a'})}));
  app.use(express.cookieParser('keyboard-cat'));
  app.use(express.session({
        store: redisSessionStore,
        cookie: {
            expires: false,
            maxAge: 30 * 24 * 60 * 60 * 1000
        }
    }));
});

app.get('/*', function(req, res) {
	
	redisClient.set("string key", "string val", function(err) { 
		
		if (err) console.log("Redis Set Key Error: " + err);
		
		res.json({
		    status: "ok",
		    error: err
		  });
		
	});
  
});

app.get('/hello/:name', function(req, res) {
  res.json({
    hello: req.params.name
  });
});

var port = process.env.HTTP_PORT || app_config.app_port || 3000;
server.listen(port);
console.log('Listening on port ' + port);








