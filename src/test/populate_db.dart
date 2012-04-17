#library('loxal:initDb');
#import('/Users/alex/my/src/mongo-dart/lib/mongo.dart');

class PopulateDb {
  void create() {
    print('Create...');
    final Map<String, Map> users = new Map<String, Map>();
    
    final Future insertData = dbConnection.chain((o) {
      vote.insertAll([
         {'nameFirst': 'Alexander', 'nameLast': 'Orlov', 'email': 'alexander.orlov@loxal.net'},
         {'nameFirst': 'Alexander', 'nameLast': 'Orlov', 'email': 'alexander.orlov@loxal.net'},
        ]);
      return vote.find().each((v) {users[v["nameFirst"]] = v;});
    });
  }
  
  Db db;
  Future<bool> dbConnection;
  DbCollection vote;
  
  final String dbName = 'vote';
  final String collection = 'vote';
  
  PopulateDb() {
    db = new Db(dbName);
    print("Connecting to ${db.serverConfig.host}:${db.serverConfig.port}");
    dbConnection = db.open();
    vote = db.collection(collection);
  }
  
  void read() {
    print('Read...');
    var readData = dbConnection.chain((v) {
      return vote.find().each(
        (o) => print(o)
        );
    });
    
    readData.then((onComplete) => db.close());  
  }
  
  void cleanup() {
    print('Remove...');
//      vote.remove();
    var clear = this.dbConnection.chain((o) {
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
  populateDb.create();
  populateDb.read();
  populateDb.cleanup();
  print('End.');
}
