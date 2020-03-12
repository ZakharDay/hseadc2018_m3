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

end
