class ImagesController < ApplicationController
	def serve
		path = "/app/assets/images/cards/#{params[:filename]}"

		send_file( path,
			:disposition => 'inline',
			:type => 'image/png',
			:x_sendfile => true )
	end
end
