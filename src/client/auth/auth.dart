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


            test('OAuth: acquire token',

                () {
                final String authEndpoint = 'https://accounts.google.com/o/oauth2/auth';
                final String clientId = '792391862458-v4278tvojhpdmi5880navvn3u6gm4bhv.apps.googleusercontent.com';
                final String clientSecret = 'CTmMahrGSXywQsEYimpAZGIT';
                final String redirectUri = 'http://localhost:8080/auth/main.html';
                final String responseType = 'token';
                final String approvalPrompt = 'auto';
                final String scope = 'https://www.googleapis.com/auth/tasks.readonly';
                final String accessType = 'online';

                final String acquireAccessTokenUrl ='$authEndpoint?redirect_uri=${encodeUriComponent(redirectUri)}&response_type=$responseType&client_id=$clientId&approval_prompt=$approvalPrompt&scope=${encodeUriComponent(scope)}&access_type=$accessType';
                print(acquireAccessTokenUrl);

                if (window.location.hash == '') window.location.assign(acquireAccessTokenUrl);
            });

            test('Retrieve task lists',

                () {
                final String retrieveTaskLists ='https://www.googleapis.com/tasks/v1/users/@me/lists';
                print(retrieveTaskLists);

                String authFragment = window.location.hash;
                List<String> subFragmnets = authFragment.substring(1).split('&').map((e) => e.split('='));
                Map<String, String> param = {};
                subFragmnets.forEach((piece) => param[piece[0]] = piece[1]);
                print(param);

                final String accessToken = param['access_token'];

                final XMLHttpRequest req = new XMLHttpRequest();
                req.open('GET', retrieveTaskLists);
                req.overrideMimeType('application/json; charset=UTF-8');
                req.setRequestHeader('Authorization', 'OAuth $accessToken');
                req.on.load.add((Event e) {
                    print(req.responseText);
                });
                req.send();

            });

        });
    });

}

//    https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Ftasks.readonly&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Flbe%2Foauth2callback.html&response_type=token&client_id=792391862458.apps.googleusercontent.com