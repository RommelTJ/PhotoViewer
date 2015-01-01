package com.photo

class Picture {
    String caption
    String description
    byte[] rawImage
    User user
    Album album
    SortedSet images

    static belongsTo = [Album, User]

    static hasMany = [images:Image]

    static transients = ['rawImage']

    static constraints = {
        caption(nullable:true, maxSize:40)
        description(nullable:true, maxSize:1024)
    }

    static mapping = {
        user unique: false
        album unique: false
    }

}
