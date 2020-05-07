require 'test_helper'

class FavouriteProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @favourite_product = favourite_products(:one)
  end

  test "should get index" do
    get favourite_products_url
    assert_response :success
  end

  test "should get new" do
    get new_favourite_product_url
    assert_response :success
  end

  test "should create favourite_product" do
    assert_difference('FavouriteProduct.count') do
      post favourite_products_url, params: { favourite_product: { product_id: @favourite_product.product_id, user_id: @favourite_product.user_id } }
    end

    assert_redirected_to favourite_product_url(FavouriteProduct.last)
  end

  test "should show favourite_product" do
    get favourite_product_url(@favourite_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_favourite_product_url(@favourite_product)
    assert_response :success
  end

  test "should update favourite_product" do
    patch favourite_product_url(@favourite_product), params: { favourite_product: { product_id: @favourite_product.product_id, user_id: @favourite_product.user_id } }
    assert_redirected_to favourite_product_url(@favourite_product)
  end

  test "should destroy favourite_product" do
    assert_difference('FavouriteProduct.count', -1) do
      delete favourite_product_url(@favourite_product)
    end

    assert_redirected_to favourite_products_url
  end
end
