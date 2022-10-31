class ApplicationController < ActionController::API
	before_action :authenticate_user
	private
	def authenticate_user
    	#byebug
    	token = request.headers['authorization']
    	token = token.split(' ').last if token
    	#byebug
    	begin
      		@decoded = JsonWebToken.decode(token)
      		@current_user = User.find(@decoded[:user_id])
    	rescue ActiveRecord::RecordNotFound => e
      		render json: { errors: e.message }, status: :unauthorized
    	rescue JWT::DecodeError => e
      		render json: { errors: e.message }, status: :unauthorized
    	end	
	end
end
