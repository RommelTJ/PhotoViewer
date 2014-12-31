package com.photo

/**
 * Created by Rommel on 12/30/2014.
 */
import grails.test.*

class UserTests extends GrailsUnitTestCase {

    protected void setUp() {
        User.list()*.delete()
    }

    protected void tearDown() {
    }

    void testAddUser() {
        User u = new User(userId: "ChuckNorris", password: "kickme", motto: "Just this guy");
        u.save();
        assertEquals 1, User.count()
    }
}
