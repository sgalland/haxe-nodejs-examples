import haxe.Resource;
import js.Node;
import js.node.console.Console;
import js.node.Querystring;
import sys.io.File;
import haxe.Template;
import js.html.Request;
import js.node.http.ServerResponse;
import js.node.http.IncomingMessage;
import js.node.Http;

class Main {
	static function main() {
		var server = Http.createServer(function(request:IncomingMessage, response:ServerResponse) {
			response.writeHead(200, {"Content-Type": "text/html"});
			var result = Querystring.parse(request.url, "/?");
			response.write(executeTemplate("home_index", {name: result["name"]}));
			response.end();
			Node.console.log(request.url);
		});

		var hostname = "127.0.0.1";
		var port = 8000;

		server.listen(port, hostname, function() {
			Node.console.log('Server running at $hostname:$port');
		});
	}

	static function executeTemplate(viewName:String, data):String {
		var viewTemplate = new Template(Resource.getString(viewName));
		var viewOutput = viewTemplate.execute(data);

		var template = new Template(Resource.getString("template"));
		return template.execute({content: viewOutput});
	}
}
