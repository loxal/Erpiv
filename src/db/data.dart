/*
 * Copyright 2012 Alexander Orlov <alexander.orlov@loxal.net>. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

class Data {

  Data() {
    // AppUser
    final List<String> mails = [
        "alexander.orlov@loxal.net", "kathryn.test@loxal.net", "tom.test@loxal.net",
        "tuvok.test@loxal.net", "kes.test@loxal.net", "b.elana.test@loxal.net",
        "neelix.test@loxal.net", "doctor.test@loxal.net", "chakotay.test@loxal.net",
        "seven.test@loxal.net",
    ];
    
    // Resource
    List<String> names = [
        "Alex", "Kathryn.test", "Tom.test",
        "Tuvok.test", "Kes.test", "B'Elana.test",
        "Neelix.test", "Doctor.test", "Chakotay.test",
        "Seven.test",
        ];

    // Employee
    List<String> namesFirst = [
        "Alfa", "Bravo", "Charlie",
        "Delta", "Echo", "Foxtrot",
        "Golf", "Hotel", "India",
        "Juliet",
        ];

    List<String> namesLast = [
        "Aleksandro", "Bartolomeo", "Davido",
        "Eduardo", "Georgo", "Henriko",
        "Johano", "Karlo", "Lino",
        "Patriko",
        ];
    
    final List<Date> births = [
        new Date(83, 5, 6, 0, 0, 0, 0), new Date(84, 6, 7, 0, 0, 0, 0), new Date(85, 7, 8, 0, 0, 0, 0),
        new Date(86, 8, 9, 0, 0, 0, 0), new Date(87, 9, 10, 0, 0, 0, 0), new Date(88, 10, 11, 0, 0, 0, 0),
        new Date(89, 11, 12, 0, 0, 0, 0), new Date(90, 12, 13, 0, 0, 0, 0), new Date(91, 1, 14, 0, 0, 0, 0),
        new Date(92, 2, 15, 0, 0, 0, 0),
        ];
  }
}
