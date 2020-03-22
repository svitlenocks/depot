class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_action :authorize

  protected

  def authorize
    redirect_to(login_url, notice: "Please login") unless User.find_by(id: session[:user_id])
  end

  def set_i18n_locale_from_params
    locale = params[:locale]

    if locale
      if I18n.available_locales.map(&:to_s).include?(locale)
        I18n.locale = locale
      else
        flash.now[:notice] = "#{locale} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
