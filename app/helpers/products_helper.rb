module ProductsHelper

  def count_products_by_color(color, product)
    product_items = color.product_items.where(product_id: product.id)

    [
      color.name,
      ' (',
      product_items.count.to_s,
      ')'
    ].join()
  end

  def product_price(price)
    number_to_currency(price, unit: "₽", separator: ",", delimiter: " ", format: "%n %u", precision: 0)
  end

  def sale_price(price)
    product_price(price * 0.9)
  end

end
