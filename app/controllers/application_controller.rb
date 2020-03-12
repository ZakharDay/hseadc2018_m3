class ApplicationController < ActionController::Base
  before_action :set_cart

  def set_cart
    @cart = User.first.carts.last
  end

end
