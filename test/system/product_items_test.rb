require "application_system_test_case"

class ProductItemsTest < ApplicationSystemTestCase
  setup do
    @product_item = product_items(:one)
  end

  test "visiting the index" do
    visit product_items_url
    assert_selector "h1", text: "Product Items"
  end

  test "creating a Product item" do
    visit product_items_url
    click_on "New Product Item"

    fill_in "Color", with: @product_item.color_id
    fill_in "Product", with: @product_item.product_id
    fill_in "Serial number", with: @product_item.serial_number
    click_on "Create Product item"

    assert_text "Product item was successfully created"
    click_on "Back"
  end

  test "updating a Product item" do
    visit product_items_url
    click_on "Edit", match: :first

    fill_in "Color", with: @product_item.color_id
    fill_in "Product", with: @product_item.product_id
    fill_in "Serial number", with: @product_item.serial_number
    click_on "Update Product item"

    assert_text "Product item was successfully updated"
    click_on "Back"
  end

  test "destroying a Product item" do
    visit product_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product item was successfully destroyed"
  end
end
