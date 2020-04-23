class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :set_cart

  def set_cart
    if user_signed_in?
      @cart = User.first.carts.last
    else
      cart_uuid = cookies[:cart_uuid]

      if cart_uuid
        @cart = Cart.find_by_uuid(cart_uuid)

        unless @cart
          uuid = SecureRandom.uuid
          @cart = Cart.create!(uuid: uuid)
          cookies[:cart_uuid] = uuid
        end
      else
        uuid = SecureRandom.uuid
        @cart = Cart.create!(uuid: uuid)
        cookies[:cart_uuid] = uuid
      end
    end
  end

end
