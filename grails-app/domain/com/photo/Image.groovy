package com.photo

class Image implements Comparable{
    Integer size
    String mimeType
    byte[] data
    Integer width
    Integer height
    Picture picture

    static transients = ['rawImage']

    static belongsTo = [Picture]

    static constraints = {
        data(maxSize:1024*1024)
    }

    static final Integer ORIGINAL = 0
    static final Integer SMALL = 1
    static final Integer MEDIUM = 2
    static final Integer LARGE = 3

    static final Integer[] WIDTH = [0, 100, 250, 500]
    static final Integer[] HEIGHT = [0, 100, 250, 500]

    int compareTo(other) {
        size.compareTo(other.size)
    }
}
