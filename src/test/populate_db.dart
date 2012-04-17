#library('Initialization');
#import('/Users/alex/my/src/mongo-dart/lib/mongo.dart');

class PopulateDb {
  void init() {
    print('init...');
    final Map<String, Map> users = new Map<String, Map>();
    
    final Future insertData = dbConnection.chain((o) {
      vote = db.collection(collection);
      vote.insertAll(
        [
         {'nameFirst': 'Alexander', 'nameLast': 'Orlov', 'email': 'alexander.orlov@loxal.net'},
        ]
      );
      return vote.find().each((v) {users[v["nameFirst"]] = v;});
    });
    
//    insertData.then((onComplete) => db.close());  
  }
  
  Db db;
  var dbConnection;
  DbCollection vote;
  
  final String dbName = 'vote';
  final String collection = 'vote';
  PopulateDb() {
    db = new Db(dbName);
    print("Connecting to ${db.serverConfig.host}:${db.serverConfig.port}");
    dbConnection = db.open();
  }
  
  void read() {
    print('read...');
    vote = db.collection(collection);
    var readData = dbConnection.chain((v) {
      return vote.find().each(
        (o) => print(o)
        );
    });
    
//    readData.then((onComplete) => db.close());  
  }
  
  void cleanup() {
    print('cleanup...');
    var clear = this.dbConnection.chain((o) {
//      vote = db.collection(collection);
//      vote.remove();
      return vote.findOne({'nameFirst':'Alexander'});
    });
    clear.then((onComplete) {
            print('Completed.');
            db.close();
      });  
  }
}

void main() {
  final PopulateDb populateDb = new PopulateDb();
  populateDb.init();
  populateDb.read();
  populateDb.cleanup();
  populateDb.db.close();
}
