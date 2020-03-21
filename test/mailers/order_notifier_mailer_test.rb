require 'test_helper'

class OrderNotifierMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifierMailer.received(orders(:one))
    assert_equal "Order Confirmation at the Pragmatic Store", mail.subject
    assert_equal [orders(:one).email], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match(/1 x Programming Ruby 1.9/, mail.body.encoded)
  end

  test "shipped" do
    mail = OrderNotifierMailer.shipped(orders(:one))
    assert_equal "Order from Pragmatic Store shipped", mail.subject
    assert_equal [orders(:one).email], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match(%r{<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>}, mail.body.encoded)
  end
end
