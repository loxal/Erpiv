#library('loxal:Incubator');

#import('dart:html');
//#import('dart:uri');


Map<String, String> getUriParams(String uriSearch) {
  if (uriSearch != '') {
    final List<String> paramValuePairs = uriSearch.substring(1).split('&');

    var paramMapping = new HashMap<String, String>();
    paramValuePairs.forEach((e) {
      if (e.contains('=')) {
        final paramValue = e.split('=');
        paramMapping[paramValue[0]] = paramValue[1];
      } else {
        paramMapping[e] = '';
      }
    });
    return paramMapping;
  }
}

void main() {
  final IFrameElement moduleContainer = query('#module');

  final uriSearch = window.location.search;
  final paramMapping = getUriParams(uriSearch);

  final moduleFqn = paramMapping['module'];
  final moduleSrc = '$moduleFqn/$moduleFqn.nocache.js';

  moduleContainer.src = moduleSrc;

}
