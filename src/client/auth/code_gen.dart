#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
#import('/Users/alex/my/src/dart/dart/lib/unittest/vm_config.dart');
#import('../schemas/TaskLists.dart');
#import('dart:io');
#import('dart:json');


class CodeGen {
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

    void blub1() {
        File file = new File('tasks-api.json');
//        print(file.readAsTextSync());

//        print("---");

        FileInputStream input = file.openInputStream();
//        StringInputStream strInput = new StringInputStream(input, "UTF-8");
        StringInputStream strInput = new StringInputStream(input);

        strInput.onData =

            () {
            print(strInput.read());
            input.close();
        };
    }

    void write() {
        var logFile = new File('log.txt');
        var out = logFile.openOutputStream(FileMode.WRITE);
        out.writeString('FILE ACCESSED ${new Date.now()}');
        out.close();
    }

    CodeGen() {
//        readApiAsJson();
//        write();

        blub1();
    }
}

void main() {
    useVmConfiguration();
    new CodeGen();
//    http://www.dartlang.org/docs/library-tour/#dartio---file-and-socket-io-for-command-line-apps
}