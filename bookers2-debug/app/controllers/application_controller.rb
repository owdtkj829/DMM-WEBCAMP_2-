class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :logged_in_user
  skip_before_action:logged_in_user,only:[:new,:create]

  def logged_in_user
        unless logged_in?
          redirect_to new_user_session_path
        end
  end

  def logged_in?
      !current_user.nil?
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path 
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end
end
