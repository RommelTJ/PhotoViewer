package com.photo

class AlbumController {
    def scaffold = true

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
