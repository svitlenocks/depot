module CartsHelper
  def show_checkout_button
    controller_name != "orders" && action_name != "new"
  end
end
