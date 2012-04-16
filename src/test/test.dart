#library('loxal:test');

#import('/Users/alex/my/src/mongo-dart/lib/mongo.dart');
#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
#import('dart:isolate');

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
  
  void testStudent() {
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
    MongoQueryMessage queryMessage = new MongoQueryMessage("dddsadfsadfb.\$cmd", 0, 0, 1, {"ping":233}, null);
    Future<MongoReplyMessage> replyFuture = conn.query(queryMessage);
    replyFuture.then((msg) {
      Expect.mapEquals({'ok': 1.000000}, msg.documents[0]);
      conn.close();
    });
  }
}

runInIsolate() {
  print("hello from an isolate!");
}

echo() {
  print('blub');
  port.receive((msg, SendPort reply) {
    print("I receivedddddd: $msg");
    reply.send("I received: $msg");
  });
}
void main() {
  SendPort sendPort = spawnFunction(echo);
  Future<String> fut = sendPort.call("Hello from main!!!!");
  
  fut.then((reply) {
    print(reply);    // I received: Hello from main
  });
  
  spawnFunction(runInIsolate);
  
  final Test t1 = new Test();
  group('My Tests',(){
    test('Test ping', t1.test1);
  });
  
  print(111222);
  final Test t = new Test();
  t.test1();
  t.test();
  t.testStudent();
}
