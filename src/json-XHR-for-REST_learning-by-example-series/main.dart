#library('loxal:LBE');

#import('dart:html');
#import('/Users/alex/my/src/DartJSONP/DartJSONP.dart');

void showTweets() {
  var callbackMethod = "callbackMethod";
  final JsonpCallback twitterCallback = new JsonpCallback(callbackMethod);
  
  twitterCallback.onDataReceived = (Map data) {
    print(data);
  };

  var twitterUrl = "http://search.twitter.com/search.json?q=dartlangg&callback=$callbackMethod";
  twitterCallback.doCallback(twitterUrl);
}

void main() { // here is where the app execution starts
  showTweets();  
}