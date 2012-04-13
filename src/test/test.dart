#library('loxal:test');

#import('/Users/alex/my/src/mongo-dart/lib/mongo.dart');
//#import('/Users/alex/my/src/mongo-dart/lib/bson/bson.dart');
//#import("dart:io");
//#import('dart:builtin');
#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest_vm.dart');

class Test {
  void test() {
    Connection conn = new Connection(); 
    conn.connect();
    MongoQueryMessage queryMessage = new MongoQueryMessage("db.\$cmd",0,0,1,{"ping":1},null);
    var replyFuture = conn.query(queryMessage);
    replyFuture.then((msg) {
      Expect.mapEquals({'ok': 1.0},msg.documents[0]);
      conn.close();
    });
  }
  
  void testStudent(){
    Connection conn = new Connection();
    conn.connect();
    MongoQueryMessage queryMessage = new MongoQueryMessage("test.student",0,0,10,{"name":"Daniil"},null);
    Future<MongoReplyMessage> replyFuture = conn.query(queryMessage);
    replyFuture.then((msg) {
      for (var each in msg.documents){
      }
      conn.close();
    });
  }
  
  void test1() {
    Connection conn = new Connection(); 
    conn.connect();
    MongoQueryMessage queryMessage = new MongoQueryMessage("db.\$cmd", 0, 0, 1, {"ping":1}, null);
    Future<MongoReplyMessage> replyFuture = conn.query(queryMessage);
    replyFuture.then((msg) {
      Expect.mapEquals({'ok': 1.000000}, msg.documents[0]);
      conn.close();
    });
  }
  
}

main() {
  print(111222);
  final Test t = new Test();
  t.test1();
  t.test();
  t.testStudent();
}
