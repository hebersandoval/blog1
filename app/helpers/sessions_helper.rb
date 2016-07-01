module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    # this places a temporary cookie on the user’s browser containing an encrypted version of the user’s id, which allows us to retrieve the id on subsequent pages using session[:user_id]
    session[:user_id] = user.id
  end
end
