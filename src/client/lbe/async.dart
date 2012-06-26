#import('dart:html');
//#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
#import('http://dart.googlecode.com/svn/branches/bleeding_edge/dart/lib/unittest/unittest.dart');
//#import('/Users/alex/my/src/dart/dart/lib/unittest/unittest.dart');
#import('http://dart.googlecode.com/svn/branches/bleeding_edge/dart/lib/unittest/html_config.dart');


void main() {
    useHtmlConfiguration();

    test('aync test',

        () {
        window.setTimeout(expectAsync0(() {
            print("timout occurred");
        }), 1000);
    });

}