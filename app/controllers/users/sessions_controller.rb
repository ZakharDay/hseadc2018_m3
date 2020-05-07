# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super

    guest_uuid = cookies[:guest_uuid]
    user_id = current_user.id
    user_carts = Cart.where(guest_uuid: guest_uuid)

    user_carts.each do |cart|
      if cart.user_id != user_id
        cart.update_attribute(:user_id, user_id)
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
