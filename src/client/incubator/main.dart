#library('loxal:Incubator');

#import('dart:html');
#import('dart:uri');

void main() {

  final String uriSearch = window.location.search;
  final List<String> paramValuePairs = uriSearch.substring(1).split('&');
  final paramMaps = new List<String>();
  paramValuePairs.forEach((paramValuePair) => paramMaps.addAll(paramValuePair.split('=')));

  var paramMapping = new HashMap<String, String>();
//  print(paramMaps[2]);
  paramMapping.putIfAbsent();

//print(paramMaps);
//print(paramMaps[1]);
//  paramMapping.putIfAbsent('',() => 'eee');
//  print(paramMapping['module']);

}
