class BandsController < ApplicationController

    def index
        @bands = Band.all
        # @bands = [] if !@bands
        render :index
    end

    def new
        @band = Band.new
        render :new
    end

    def create
        @band = Band.new(name: params[:band][:name])
        if @band && @band.save
            redirect_to band_url(@band)
        else
            flash[:errors] = @band.errors.full_messages
            redirect_to bands_url
        end
    end

    def edit
        @band ||= Band.find_by(id: params[:id])
        if @band
            render :edit
        else
            flash[:errors] = ["That band does not exist."]
            redirect_to bands_url
        end
    end

    def update
        @band = Band.find_by(id: params[:id])
        if @band && @band.update(name: params[:band][:name])
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :edit
        end
    end

    def show
        @band = Band.find_by(id: params[:id])
        if @band
            render :show
        else
            flash.now[:errors] = @band.errors.full_messages
            render :index
        end
    end

    def destroy
        @band = Band.find_by(id: params[:id])
        if @band && @band.destroy
            flash[:alert] = ["The band #{@band.name} has been deleted."]
            redirect_to bands_url
        else
            flash.now[:errors] = ["That band does not exist"]
            render :index
        end
    end



end