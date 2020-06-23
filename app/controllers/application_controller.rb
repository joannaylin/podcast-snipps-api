class ApplicationController < ActionController::API
  before_action :authorized, only: [:current_user]

  # issue a token, store payload in token
  def issue_token(payload)
    JWT.encode(payload, ENV["JWT_SECRET"], ENV["JWT_ALGORITHM"])
  end

  # Bearer <token>
  # grab jwt token out of request.headers
  def auth_header 
    request.headers["Authorization"]
  end

  def decoded_token(payload)
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(payload, ENV["JWT_SECRET"], ENV["JWT_ALGORITHM"])
      rescue JWT::DecodeError
        return nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    # respond with error message unless user is logged in
    render json: {error: "Access denied: not authorized."}, status: 401 unless logged_in?
  end

end
