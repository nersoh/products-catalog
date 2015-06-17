module SessionsHelper
	def log_in(user, remember=0)
		if remember
			cookies.permanent.signed[:auth_token] = user.auth_token
		else
			cookies.signed[:auth_token] = user.auth_token
		end
	end

	def current_user
		@current_user = User.find_by(auth_token: cookies.signed[:auth_token]) \
																if cookies.signed[:auth_token]
	end

	def current_user?(user)
		current_user == user
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		cookies.delete(:auth_token)
	end
end
