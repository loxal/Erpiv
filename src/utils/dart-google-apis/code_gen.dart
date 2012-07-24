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
  static final String descriptionJsonKey = 'description';
  static final String tasksClassesFilePath = 'tasks_classes.dart';

  static Map<String, String> typeMap = const {
  'string': 'String',
  'boolean': 'bool',
  };

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

      for (var b in bytes) {
        print(b);
      }
    };

  }

  void blub() {
    File f = new File('tasks-api.json');
    InputStream fileStream = f.openInputStream();
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
    final File tasksClasses = new File(CodeGen.tasksClassesFilePath);

    try {
      tasksClasses.deleteSync();
    } catch (FileIOException e) {
      print(e);
    }
    final OutputStream tasksClassesStream = tasksClasses.openOutputStream(FileMode.APPEND);
    final Map<String, Object> tasksApi = JSON.parse(jsonApi);

    final StringBuffer sb = new StringBuffer();

    tasksApi[classesJsonKey].forEach((final String key, final Map<String, Object> value){
      Dynamic fieldsPropertiesArray = value[propertiesJsonKey];

      sb.add('''class $key {\n'''); // file name gen/tasks_classes.dart
      sb.add(propertiesArray(fieldsPropertiesArray));
      sb.add('}\n\n');
    });

    tasksClassesStream.writeString(sb.toString());
    tasksClassesStream.close();
  }

  String propertiesArray(Dynamic fieldsPropertiesArray) {
    final StringBuffer sb = new StringBuffer();

    fieldsPropertiesArray.forEach((final String key, final Map<String, Object> value) {
      if (value[typeJsonKey] == 'array') {
        sb.add('// ARRAY\n');
        if (value['items']['properties'] != null) {
          sb.add(propertiesArray(value['items'][propertiesJsonKey]));
        }
        else {
          sb.add('${value['items']['\$ref']} object;');
        }
      } else if (value[typeJsonKey] == 'object' && value['id'] == 'array') {
      } else {
        sb.add('''
                    /** ${value[descriptionJsonKey]} */
                    ${typeMap[value[typeJsonKey]]} $key;
                ''');
      }
    });

    return sb;
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

      print(decodeUtf8(bytes));
    };
  }
}