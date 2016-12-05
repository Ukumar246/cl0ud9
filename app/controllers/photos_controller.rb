class PhotosController < ApplicationController
	def new
		@photo = Photo.new
	end

	def create
		@photo = Photo.new(photo_params)
		@photo.save

		redirect_to url_for(:controller=>'tournaments', :action=>'organize', :id=>params[:photo][:tournament_id])
	end

	def destroy
		puts "calling destroy"
		@tournament = Tournament.find params[:tournament_id]
    @photo = @tournament.photo.find params[:id]
    Cloudinary::Api.delete_resources_by_tag(@photo.photoLink)
    @photo.remove_photoLink!
    @photo.destroy
		redirect_to url_for(:controller=>'tournaments', :action=>'organize', :id=>@tournament.id)
	end

	private
	def photo_params
		params.require(:photo).permit(:photoLink, :tournament_id)
	end

end
