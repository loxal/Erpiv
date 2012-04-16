#library("dartwatch:blogserver");              //any reasonable name
#import("../crimson/core/crimson.dart");       //the core crimsonHttp server library
#import("../crimson/handlers/handlers.dart");  //builtin handlers library
#import("../mongo-dart/lib/mongo.dart");       //mongodb drivers.
#import("dart:json");
#import("dart:io");

// http://dartwatch.com/index.php/2012/03/building-a-client-server-dart-app-part-1-server-side/
class BlogServer {
 
  //todo - add mongo-db support
 
  void run() {
 
    CrimsonHttpServer server = new CrimsonHttpServer();
    CrimsonModule module = new CrimsonModule(server);
    module.handlers
               .addEndpoint(new Route("/post/all", "GET", getPosts))  //return all posts - closure
               .addEndpoint(new Route("/post", "POST", addPost)) //add a post - closure
               .addEndpoint(new StaticFile("./client"));
 
    server.modules["*"] = module;  //this is the default module.
 
    server.listen("127.0.0.1", 8083);
  }
 
  Future addPost(HttpRequest req,res,data) {
    //todo - fill in the blanks
  }
 
  Future Future getPosts(req,res,CrimsonData data) {
    //todo - fill in the blanks
  }
 
}
 
void main() {
new BlogServer().run();
}