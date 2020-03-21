class OrderNotifierMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  def received(order)
    @order = order

    mail to: order.email, subject: "Order Confirmation at the Pragmatic Store"
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: "Order from Pragmatic Store shipped"
  end
end
