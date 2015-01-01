package com.photo

class PictureController {

    def scaffold = true

    def imageService

    def save = {
        def album = Album.get(params.album.id)
        def user = album.user
        params.user = user
        params.album = album
        def picture = new Picture(params)
        if (!picture.hasErrors()) {
            user.addToPhotos(picture)
            album.addToPictures(picture)
            picture.save(flush:true)

            if (params.rawImage) {
                def images = imageService.createImages(picture, params.rawImage)
                images.each {image ->
                    picture.addToImages(image)
                }
            }
            redirect(action:show, id:picture.id)
        }
        else
            render(view: 'create', model: [ pictureInstance: picture ])
    }

    def update = {
        def picture = Picture.get(params.id)
        def oldAlbum = picture.album
        def album = Album.get(params.album.id)
        def user = album.user
        params.user = user
        params.album = album


        picture.properties = params
        if (!picture.hasErrors()) {
            if (album.id != oldAlbum.id) {
                album.addToPictures(picture)
                oldAlbum.removeFromPictures(picture)
            }
            picture.save(flush:true)
            redirect(action:show, id:picture.id)
        }
        else
            render(view: 'edit', model: [ pictureInstance: picture ])

    }

    def displayMediumPhoto = {
        def picture = Picture.get(params.id)
        if (picture.images) {
            def image = Image.findByPictureAndSize(picture, Image.MEDIUM)
            response.setContentType(image.mimeType)
            response.setContentLength(image.data.length)
            response.getOutputStream().write(image.data)
        }
    }

}