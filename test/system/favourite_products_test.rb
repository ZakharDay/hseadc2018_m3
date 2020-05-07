require "application_system_test_case"

class FavouriteProductsTest < ApplicationSystemTestCase
  setup do
    @favourite_product = favourite_products(:one)
  end

  test "visiting the index" do
    visit favourite_products_url
    assert_selector "h1", text: "Favourite Products"
  end

  test "creating a Favourite product" do
    visit favourite_products_url
    click_on "New Favourite Product"

    fill_in "Product", with: @favourite_product.product_id
    fill_in "User", with: @favourite_product.user_id
    click_on "Create Favourite product"

    assert_text "Favourite product was successfully created"
    click_on "Back"
  end

  test "updating a Favourite product" do
    visit favourite_products_url
    click_on "Edit", match: :first

    fill_in "Product", with: @favourite_product.product_id
    fill_in "User", with: @favourite_product.user_id
    click_on "Update Favourite product"

    assert_text "Favourite product was successfully updated"
    click_on "Back"
  end

  test "destroying a Favourite product" do
    visit favourite_products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Favourite product was successfully destroyed"
  end
end
