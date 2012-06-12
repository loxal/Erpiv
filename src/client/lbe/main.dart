#library('loxal:LBE');

#import('dart:html');
#import('/Users/alex/my/src/DartJSONP/DartJSONP.dart');

void showTweets() {
    var callbackMethod = "callbackMethod";
    final JsonpCallback twitterCallback = new JsonpCallback(callbackMethod);

    twitterCallback.onDataReceived =

        (Map data) {
        print(data);
    };

    var twitterUrl = "http://search.twitter.com/search.json?q=dartlangg&callback=$callbackMethod";
    twitterCallback.doCallback(twitterUrl);
}

void main() { // here is where the app execution starts
//  showTweets();
    var emp = new Employee.fromJson({});


}

class Person {
    Person.fromJson(Map data) {
        print('in Person');
    }

    Person() {
        print('blub');
    }
}

class Employee extends Person {
// Person does not have a default constructor
// you must call super.fromJson(data)
    Employee.fromJson(Map data) {
        print('in Employee');
    }
}