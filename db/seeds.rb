@categories = nil
@colors = nil
@products = nil
@product_items = nil
@users = nil
@carts = nil

@users_names = [
  ['Yo', 'user1@test.com'],
  ['Rap', 'user2@test.com'],
  ['Lobnya', 'user3@test.com'],
  ['Admin', 'admin@test.com']
]

@categories_names = [
  {
    name: 'Mac',
    products: [['MacBook', 'product_1.jpg'], ['MacBook Pro', 'product_2.jpg']]
  }, {
    name: 'iPad',
    products: [['iPad', 'product_3.jpg'], ['iPad Pro', 'product_1.jpg'], ['iPad Mini', 'product_2.jpg']]
  }, {
    name: 'iPhone',
    products: [['iPhone 11', 'product_1.jpg'], ['iPhone 11 Pro', 'product_2.jpg']]
  }
]

@colors_names = ['black', 'white', 'yellow', 'green', 'blue', 'orange', 'silver', 'gold', 'pink', 'grey', 'cyan', 'magenta']

def seed
  reset_db

  create_colors
  @colors = Color.all

  create_categories
  @categories = Category.all

  create_categories_products
  @products = Product.all

  create_products_colors
  create_products_items
  @product_items = ProductItem.all

  create_users
  @users = User.all

  create_users_carts
  @carts = Cart.all

  fill_carts_with_products
  @carts = Cart.all

  make_few_orders
  make_one_sale
  cancel_one_order
end

def reset_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

def create_colors
  @colors_names.each { |color_name| create_color(color_name) }
end

def create_color(color_name)
  color = Color.create!(name: color_name)
  puts "Color with name #{color.name} just created"
end

def create_categories
  @categories_names.each { |category| create_category(category) }
end

def create_category(category)
  c = Category.create!(name: category[:name], cover: upload_random_cover)
  puts "Category with name #{c.name}"
end

def create_categories_products
  @categories.each do |category|
    @categories_names.each do |category_name_with_product_list|
      if category.name == category_name_with_product_list[:name]
        create_category_products(category, category_name_with_product_list[:products])
      end
    end
  end
end

def create_category_products(category, products)
  products.each { |product| create_category_product(category, product) }
end

def create_category_product(category, product)
  p = category.products.create!(name: product[0], price: (100..100000).to_a.sample)
  puts "Product with name #{p.name} just created in category with name #{p.category.name}"

  create_product_image(p.id, product[1])
end

def create_product_image(product_id, filename)
  product = Product.find(product_id)
  product_image = product.product_images.create!(image: upload_product_image(filename))
  puts "ProductImage just created with id #{product_image.id}"
end

def create_products_colors
  @products.each { |product| create_product_colors(product) }
end

def create_product_colors(product)
  product_colors_quantity = (2..@colors.count).to_a.sample

  @colors.sample(product_colors_quantity).each do |color|
    create_product_color(product, color)
  end
end

def create_product_color(product, color)
  pc = ColorsProducts.create!(product_id: product.id, color_id: color.id)
  puts "Product Color juse created with id #{pc.id} for product with id #{pc.product.id} for color with id #{pc.color.id}"
end

def create_products_items
  @products.each { |product| create_product_items(product) }
end

def create_product_items(product)
  product.colors.each do |color|
    quantity = (2..10).to_a.sample
    quantity.times { create_product_item(product, color) }
  end
end

def create_product_item(product, color)
  serial_number = SecureRandom.uuid
  product_item = product.product_items.create!(color_id: color.id, serial_number: serial_number)
  puts "Product Item just created with id #{ product_item.id } for product with id #{ product_item.product.id } with color with id #{ product_item.color.id }"
end

def create_users
  @users_names.each do |user|
    user_data = {
      name: user[0],
      email: user[1],
      password: 'testtest',
      password_confirmation: 'testtest'
    }

    user_data[:admin] = true if user[0] == 'Admin'

    u = User.create!(user_data)

    puts "User just created with id #{ u.id }"
  end
end

def create_users_carts
  @users.each { |user| create_user_cart(user) }
end

def create_user_cart(user)
  cart = user.carts.create!
  puts "Cart just created with id #{ cart.id } for user with id #{ cart.user.id }"
end

def fill_carts_with_products
  @carts.each { |cart| fill_cart_with_products(cart) }
end

def fill_cart_with_products(cart)
  quantity = (1..20).to_a.sample
  product_items = @product_items.sample(quantity)

  product_items.each { |product_item| create_cart_item(cart, product_item) }
end

def create_cart_item(cart, product_item)
  product = product_item.product
  cart_item = CartItem.create!(cart_id: cart.id, product_id: product.id, product_item_id: product_item.id, price: product.price)
  puts "Cart Item just created with id #{ cart_item.id } for product with id #{ cart_item.product.id } for product item with id #{ cart_item.product_item.id } with price #{ cart_item.price }"
end

def make_few_orders
  @carts.sample(3).each do |cart|
    order = Order.create!(cart_id: cart.id, user_id: cart.user_id)
    puts "Order with id #{order.id} just created"

    cart.cart_items.each do |cart_item|
      order_item = order.order_items.create!(product_id: cart_item.product_id, product_item_id: cart_item.product_item_id, price: cart_item.price)
      puts "OrderItem with id #{order_item.id} just created"

      product_item = cart_item.product_item
      product_item.status = 'reserved'
      product_item.save
    end
  end
end

def make_one_sale
  order = Order.last
  order.status = 'delivered'
  order.save

  order.order_items.each do |order_item|
    product_item = order_item.product_item
    product_item.status = 'sold'
    product_item.save
  end
end

def cancel_one_order
  order = Order.first
  order.status = 'canceled'
  order.save

  order.order_items.each do |order_item|
    product_item = order_item.product_item
    product_item.status = 'available'
    product_item.save
  end
end

def upload_random_cover
  uploader = CategoryCoverUploader.new(Category.new, :cover)
  uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'public/autoupload/category_covers', '*')).sample))
  uploader
end

def upload_product_image(filename)
  uploader = ProductImageUploader.new(ProductImage.new, :image)
  uploader.cache!(File.open(File.join(Rails.root, 'public/autoupload/product_images', filename)))
  uploader
end

seed
