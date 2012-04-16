/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:model');
#import('/Users/alex/my/src/mongo-dart/lib/mongo.dart');
//#import("../lib/mongo.dart");
#import("dart:builtin");

class Main {
  
}

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

void myNew() {
  setVerboseState();
  final Db db = new Db("vote");
  print("Connecting to ${db.serverConfig.host}:${db.serverConfig.port}");
  DbCollection vote;
  Map<String, Map> users = new Map<String, Map>();
  db.open().chain((o) {
    print(">> Dropping mongo-dart-blog db");
    db.drop();
    print("===================================================================================");
    print(">> Adding Authors");
    vote = db.collection('vote');
    vote.insertAll(
      [{'name':'William Shakespeare', 'email':'william@shakespeare.com', 'age':587},
      {'name':'Jorge Luis Borges', 'email':'jorge@borges.com', 'age':123}]
    );
    return vote.find().each((v){users[v["name"]] = v;});
    
  }).then((onComplete) => db.close());
    
  }
void main() {
  test();
  
  myNew();
}

