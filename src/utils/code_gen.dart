#library('code_gen');

#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
#import('/Users/alex/my/src/dart/dart/lib/unittest/vm_config.dart');
#import('dart:io');
#import('dart:json');
#import('dart:utf');


class CodeGen {
    static final String tasksJsonApi = '../tasks-api.json';

    static final String classesJsonKey = 'schemas';
    static final String propertiesJsonKey = 'properties';

    void readApiAsJson() {
        var config = new File('tasks-api.json');
        var inputStream = config.openInputStream();

        inputStream.onError =

            (e) => print(e);
        inputStream.onClosed =

            () => print("file is now closed");
        inputStream.onData =

            () {
            List<int> bytes = inputStream.read();
            print("Read ${bytes.length} bytes from stream");

            for (byte b in bytes) {
                print(b);
            }
        };

    }

    void blub() {
        File f = new File('tasks-api.json');
        FileInputStream fileStream = f.openInputStream();
        StringInputStream stringStream = new StringInputStream(fileStream);
        print(stringStream.read());
        fileStream.close();
    }

    String readJsonApi() {
        final File jsonApi = new File(tasksJsonApi);
        final String jsonApiContent = jsonApi.readAsTextSync();

        return jsonApiContent;
    }

    void parseJsonApi(final String jsonApi) {
        final Map<String, Object> tasksApi = JSON.parse(jsonApi);

        tasksApi[classesJsonKey].forEach((key, value){
            print(key); // file name gen/tasks_classes.dart
            print(value[propertiesJsonKey]);
        });

        print(tasksApi['schemas']['Task']['type']);
    }

    void streamingJsonApi() {
        var config = new File(tasksJsonApi);
        var inputStream = config.openInputStream();

        inputStream.onError =

            (e) => print(e);
        inputStream.onClosed =

            () => print("file is now closed");
        inputStream.onData =

            () {
            List<int> bytes = inputStream.read();
            print("Read ${bytes.length} bytes from stream");
//          bytes.forEach( (e) => print(String.charCodeAt(e)) );
//          print(bytes.forEach( (e) => String.charCodeAt(e) ));
//      print(String.decodeUtf16(bytes));

            print(decodeUtf8(bytes));
        };
    }

    void writeJsonApiDartClass() {
        var logFile = new File('log.txt');
        var out = logFile.openOutputStream(FileMode.WRITE);
        out.writeString('FILE ACCESSED ${new Date.now()}');
        out.close();
    }

    void deleteJsonApiDartClass() {
        var logFile = new File('log.txt');
        logFile.deleteSync();
    }

    void write() {
        var logFile = new File('log.txt');
        var out = logFile.openOutputStream(FileMode.WRITE);
        out.writeString('FILE ACCESSED ${new Date.now()}');
        out.close();
    }
}