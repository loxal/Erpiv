/*
 * Copyright 2015 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

import 'dart:io';

void main() {
  HttpServer server = new HttpServer();
  WebSocketHandler wsHandler = new WebSocketHandler();
  server.addRequestHandler((req) => req.path == "/ws", wsHandler.onRequest);
  
  wsHandler.onOpen = (WebSocketConnection conn) {
    print('new connection');
    
    conn.onMessage = (message) {
      print("message is $message");
      conn.send("Echo: $message");
    };
    
    conn.onClosed = (int status, String reason) {
      print('closed with $status for $reason');
    };
          
    conn.onError = (e) {
      print('Error was $e');
    };
  };
  
  server.listen('127.0.0.1', 8000);
}