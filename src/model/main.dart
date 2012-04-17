/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

#library('loxal:model');
#import('/Users/alex/my/src/mongo-dart/lib/mongo.dart');

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
//  setVerboseState();
  final Db db = new Db("vote");
  DbCollection vote;
  print("Connecting to ${db.serverConfig.host}:${db.serverConfig.port}");
  final Map<String, Map> users = new Map<String, Map>();
  final Future<bool> dbConnection = db.open();
  
  final Future insertData = dbConnection.chain((o) {
//    db.drop();
    vote = db.collection('vote');
//    vote.remove();
    vote.insertAll(
      [
       {'nameFirst': 'Alexander', 'nameLast': 'Orlov', 'email': 'alexander.orlov@loxal.net'},
       {'nameFirst': 'Seven.test', 'nameLast': 'of Nine', 'email': 'jorge@borges.com'}
       ]
    );
    return vote.find().each((v) {users[v["nameFirst"]] = v;});
    
  });
  
  final Future readData = dbConnection.chain((v) {
    return vote.find(orderBy:{'agee':1}).each(
      (auth) => print("[${auth['nameFirst']}]:[${auth['email']}]:[${auth['nameLast']}]:[${auth['agee']}]:[${auth['_id']}]")
      );
  });
  
  readData.then((onComplete) => db.close());
    
  }
void main() {
  test();
  
  myNew();
}

