@categories = [
  {
    name: 'Mac',
    products: ['MacBook', 'MacBook Pro']
  }, {
    name: 'iPad',
    products: ['iPad', 'iPad Pro', 'iPad Mini']
  }, {
    name: 'iPhone',
    products: ['iPhone 11', 'iPhone 11 Pro']
  }
]

def seed
  reset_db
  create_categories(@categories)
end

def reset_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

def create_categories(categories)
  categories.each { |category| create_category(category) }

  # categories.each do |category|
  #   create_category(category)
  # end
end

def create_category(category)
  c = Category.create!(name: category[:name])
  puts "Category with name #{c.name}"

  create_category_products(c, category[:products])
end

def create_category_products(category, products)
  products.each { |product| create_category_product(category, product) }

  # products.each do |product|
  #   create_category_product(category, product)
  # end
end

def create_category_product(category, product)
  p = category.products.create!(name: product)
  puts "Product with name #{p.name} just created in category with name #{p.category.name}"
end

seed
