#library('loxal:schema');
#import('dart:json');

class TaskLists {
    String etag;
    String kind;
    List items;
    String nextPageToken;

    TaskLists(this.etag, this.kind, this.items) {

    }

    TaskLists.to(String json){
        Object o = JSON.parse(json);
        this.etag = o['etag'];
        this.kind = o['kind'];
        this.items = o['items'];
    }

}