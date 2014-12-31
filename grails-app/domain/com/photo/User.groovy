package com.photo

class User {
    String userId
    String password
    String motto
    Date dateCreated
    Date lastUpdated
    List albums
    List photos

    static hasMany = [albums:Album, photos:Picture]

    static constraints = {
        userId(size:1..40, unique:true, blank:false)
        password(size:6..10, blank:false, validator: {password, user ->
            (password == user.userId) ? false : true
        })
        motto(nullable:true, maxSize:80)
    }

    static mapping = {
    }

    String toString() {
        userId
    }
}
