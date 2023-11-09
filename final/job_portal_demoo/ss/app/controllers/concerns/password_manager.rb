module PasswordManager
  extend ActiveSupport::Concern

  def forgot_password
    return render status: :not_found, json: 'Username must be pass' unless params[:username]

    user = User.find_by_username(params[:username])
    if user.present?
      user.generate_password_token! # generate pass token
      UserMailer.with(user:user).forgot_password_token.deliver_now
      render json: 'Email Send Successfully'
    else
      render json: { error: ['Username not found. Please check and try again.'] }, status: :not_found
    end
  end

  def reset_password
    token = params[:token]

    return render status: :not_found, json: { error: 'Token not present' } unless token

    user = User.find_by(reset_password_token: token)
    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: 'Password Update Successfully'
      else
        render status: :unprocessable_entity, json: { errors: user.errors.full_messages }
      end
    else
      render status: :gone, json: { error: ['Link not valid or expired. Try generating a new link.'] }
    end
  end
end
