class Coders::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = Coder.from_omniauth request.env['omniauth.auth']

    if @user.blank?
      flash[:warning] = 'It seems you have no contributions made so far. This is needed to log in.'
      redirect_to root_path
    else
      sign_in_and_redirect @user
      set_flash_message(:success, :success, kind: 'Github') if is_navigational_format?
    end
  end
end
