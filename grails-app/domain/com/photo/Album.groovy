package com.photo

class Album {
    String caption
    String description
    Date dateCreated
    Date lastUpdated
    User user
    List pictures

    static belongsTo = [User]

    static hasMany = [pictures:Picture]

    static mapping = {
        user unique: false
    }

    static constraints = {
        caption(nullable:true, maxSize:40)
        description(nullable:true, maxSize:1024)
    }

    String toString() {
        "${caption}"
    }
}
