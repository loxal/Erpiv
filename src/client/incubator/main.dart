#library('loxal:Incubator');

#import('dart:html');
#import('https://raw.github.com/chrisbu/DartJSONP/master/DartJSONP.dart');

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
    showTweets();
}
