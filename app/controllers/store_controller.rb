class StoreController < ApplicationController
  include CurrentCart

  skip_before_action :authorize
  before_action :set_cart

  def index
    set_locale_param = params[:set_locale]

    if set_locale_param
      redirect_to store_path(locale: set_locale_param)
    else
      @products = Product.order(:title)
    end
  end
end
