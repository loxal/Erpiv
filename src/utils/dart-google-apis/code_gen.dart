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
  static final String tasksClassesFilePath = '../dart-google-apis/gen/tasks_classes.dart';

  static Map<String, String> typeMap = const {
  'string': 'String',
  'boolean': 'bool',
  };

  String readJsonApi() {
    final File jsonApi = new File(tasksJsonApi);
    final String jsonApiContent = jsonApi.readAsTextSync();

    return jsonApiContent;
  }

  void handleTasksClaseesFile(final File tasksClasses) {
    try {
      tasksClasses.deleteSync();
    } catch (FileIOException e) {
      print(e);
    }
  }

  void parseJsonApi(final String jsonApi) {
    final File tasksClasses = new File(CodeGen.tasksClassesFilePath);
    handleTasksClaseesFile(tasksClasses);

    final OutputStream tasksClassesStream = tasksClasses.openOutputStream(FileMode.APPEND);
    final Map<String, Object> tasksApi = JSON.parse(jsonApi);

//    final String tasksClassesContent = extractClasses(tasksApi);
    final String tasksClassesContent = extractApi(tasksApi);
    tasksClassesStream.writeString(tasksClassesContent);
    tasksClassesStream.close();
  }

  String extractApi(final Map<String, Object> tasksApi){
    StringBuffer api = new StringBuffer();

    Function blu = tasksApi.forEach((String key, String value) {
      if(key == 'schemas') {
        final Map<String, String> schemas = value;
        api.add(value);

      // TODO call recursively taskApi.forEach
          // TODO define taskApi.forEach as TYPEDEF or/and as FUNCTION

      }
    });

    return api.toString();
  }

  String extractClasses(final Map<String, Object> tasksApi) {
    final StringBuffer sb = new StringBuffer();
    tasksApi[classesJsonKey].forEach((final String key, final Map<String, Object> value){
      Dynamic fieldsPropertiesArray = value[propertiesJsonKey];

      sb.add('''class $key {\n'''); // file name gen/tasks_classes.dart
      sb.add(propertiesArray(fieldsPropertiesArray));
      sb.add('}\n\n');
    });
    return sb.toString();
  }

  String propertiesArray(Dynamic fieldsPropertiesArray) {
    final StringBuffer sb = new StringBuffer();

    fieldsPropertiesArray.forEach((final String key, final Map<String, Object> value) {
      if (value[typeJsonKey] == 'array') {
        sb.add('// ARRAY\n');
        if (value['items']['properties'] != null) {
          sb.add(propertiesArray(value['items'][propertiesJsonKey]));
        } else {
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
}