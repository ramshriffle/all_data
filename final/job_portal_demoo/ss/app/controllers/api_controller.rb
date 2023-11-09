class ApiController < ActionController::API
  rescue_from CanCan::AccessDenied do |exception|
    render status: :unauthorized, json: exception.message
  end

  before_action :authorize_request
  authorize_resource

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(' ')[1] if header

    unless session[:token]
      return render status: :unauthorized, json: "First Login"
    end unless token

    begin
      @decoded = JsonWebToken.decode(token || session[:token])
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render status: :not_found, json: { errors: e.message }
    rescue JWT::DecodeError => e
      render status: :unauthorized, json: { errors: e.message }
    end
  end

  def is_login?
    return true if session[:token]
    false
  end

  # CanCan expects a current_user method to exist in the controller.
  attr_reader :current_user
end
