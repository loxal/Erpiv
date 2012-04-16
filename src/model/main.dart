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

void main() {
  test();
}

