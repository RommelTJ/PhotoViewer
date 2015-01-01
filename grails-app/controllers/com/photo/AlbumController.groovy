package com.photo

class AlbumController {

    def scaffold = true

    def update = {
        def album = Album.get(params.id)
        params.user = album.user
        album.properties = params
        if (!album.hasErrors()) {
            album.save(flush:true)
            redirect(action:show, id:album.id)
        }
        else
            render(view: 'edit', model: [ albumInstance: album ])
    }

    def save = {
        def user = User.get(params.user.id)
        params.user = user
        def album = new Album(params)
        if (!album.hasErrors()) {
            user.addToAlbums(album)
            album.save(flush:true)
            redirect(action:show, id:album.id)
        }
        else
            render(view: 'create', model: [ albumInstance: album ])
    }

}
