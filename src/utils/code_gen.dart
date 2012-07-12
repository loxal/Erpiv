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
    static final String typeJsonKey = 'type';
    static final String descriptionJsonKey = 'type';
    final String tasksClassesFilePath = 'tasks_classes.dart';

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
        final File tasksClasses = new File(tasksClassesFilePath);
        tasksClasses.deleteSync();
        final OutputStream tasksClassesStream = tasksClasses.openOutputStream(FileMode.APPEND);
        final Map<String, Object> tasksApi = JSON.parse(jsonApi);

        tasksApi[classesJsonKey].forEach((key, value){
            print(key); // file name gen/tasks_classes.dart
            final Map<String, Object> fields = value[propertiesJsonKey];
            tasksClassesStream.writeString('$key\n');
            fields.forEach((key, value) {
                print(key);
                print(value[typeJsonKey]);
                print(value[descriptionJsonKey]);
            });
        });

        tasksClassesStream.close();
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
}