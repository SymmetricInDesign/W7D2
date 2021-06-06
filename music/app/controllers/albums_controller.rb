class AlbumsController < ApplicationController

    def new
        @album ||= Album.new
        @band = Band.find_by(id: params[:band_id])
        if @band 
            render :new
        else
            flash.now[:errors] = ["Band not found"]
            redirect_to albums_url
        end
    end

    def create
        @album = Album.new(album_params)
        if @album && @album.save!
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            redirect_to albums_url
        end
    end

    def index
        @albums ||= Album.all
        render :index
    end

    def show
        @album = Album.find_by(id: params[:id])
        @band = Band.find_by(id: @album.band_id)
        if @album && @band
            render :show
        else
            flash.now[:errors] = @album.errors.full_messages + @band.errors.full_messages
            redirect_to albums_url
        end
    end


    def edit
        
    end

    def album_params
        album_params = params.require(:album).permit(:title, :year)
        album_params[:band_id] = params[:band_id]
        params["studio"] == "true" ? album_params[:studio] = true : album_params[:studio] = false
        album_params
    end

end