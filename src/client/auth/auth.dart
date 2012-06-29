#import('dart:html');
#import('http://dart.googlecode.com/svn/branches/bleeding_edge/dart/lib/unittest/unittest.dart');
#import('http://dart.googlecode.com/svn/branches/bleeding_edge/dart/lib/unittest/html_config.dart');
#import('http://dart.googlecode.com/svn/branches/bleeding_edge/dart/lib/web/web.dart');
#import('http://dart.googlecode.com/svn/branches/bleeding_edge/dart/lib/uri/uri.dart');
#import('https://raw.github.com/chrisbu/DartJSONP/master/DartJSONP.dart');

void main() {
    useHtmlConfiguration();

    group('foo',

        () {
        setUp(() {
            print('setUp');
        });
        tearDown(() {
            print('tearDown');
        });
        test('description...',

            () {
            print('desc');
        });
        test('this is a test',

            () {
            int x = 2 + 3;
            expect(x, equals(5));
        });
        test('this is another test',

            () {
            int x = 2 + 3;
            expect(x, equals(5));
        });

        test('calllback is executed once',

            () {
// wrap the callback of an asynchronous call with [expectAsync0] if
// the callback takes 0 arguments...
            window.setTimeout(expectAsync0(() {
                int x = 2 + 3;
                expect(x, equals(5));
            }), 0);

            test('aync test',

                () {
                window.setTimeout(expectAsync0(() {
                    print("timout occurred");
                }), 100);
            });
            test('XHR',

                () {

                final String clientId = '792391862458.apps.googleusercontent.com';
                final String clientSecret = '58jZ538xnuIg6png7i1fcCx0';
                final String redirectUri = 'http://localhost:8080/auth/oauthCallback.html';
                final String authBase = 'https://accounts.google.com/o/oauth2/auth';
                final String scope = 'https://www.googleapis.com/auth/tasks.readonly';

//                final String xhrReqUri ='https://accounts.google.com/o/oauth2/auth?redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Flbe%2Foauth2callback&response_type=token&client_id=594158535293-12eodu1l037af8thmouoj7o3qte2bi15.apps.googleusercontent.com&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Ftasks.readonly&access_type=online&approval_prompt=auto';
                final String xhrReqUriNew ='$authBase?redirect_uri=${encodeUriComponent(redirectUri)}&response_type=code&client_id=$clientId&approval_prompt=auto&scope=${encodeUriComponent(scope)}&access_type=online';

                print(xhrReqUriNew);

                XMLHttpRequest req = new XMLHttpRequest();
                req.open('GET', xhrReqUriNew);
//                    req.open('GET', 'http://localhost:8080/type_trainer/main.html');
                req.on.readyStateChange.add((e) {
                    print(req.response);
                });
                req.send();

            });
        });
    });

}

//    https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Ftasks.readonly&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Flbe%2Foauth2callback.html&response_type=token&client_id=792391862458.apps.googleusercontent.com