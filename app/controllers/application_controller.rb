class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :set_cart

  def set_cart
    # Проверить есть ли у гостя уже идентификатор
    guest_uuid = cookies[:guest_uuid]

    # ЕСЛИ ЕСТЬ ТО
    if guest_uuid
      if user_signed_in?
        @cart = current_user.carts.where(guest_uuid: guest_uuid, cleared: false).last
        @cart ||= current_user.carts.create!(guest_uuid: guest_uuid)
      else
        # Найти последнюю активную корзину этого гостя
        @cart = Cart.where(guest_uuid: guest_uuid, cleared: false).last
        @cart ||= Cart.create!(guest_uuid: guest_uuid)
      end
    # ЕСЛИ НЕТ ТО
    else
      # Тегировать гостевого пользователя (добавить пользователю идентификатор)
      # Создать ему корзину
      uuid = SecureRandom.uuid
      cookies[:guest_uuid] = uuid

      if user_signed_in?
        @cart = current_user.carts.create!(guest_uuid: uuid)
      else
        @cart = Cart.create!(guest_uuid: uuid)
      end
    end
  end

end
