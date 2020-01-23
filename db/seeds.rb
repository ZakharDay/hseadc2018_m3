Rake::Task['db:drop'].invoke
Rake::Task['db:create'].invoke
Rake::Task['db:migrate'].invoke

categories = ['Mac', 'iPad', 'iPhone', 'Watch', 'TV', 'Music']

categories.each do |category|
  c = Category.create!(name: category)
  puts "Category with name #{c.name}"
end

products = ['MacBook', 'MacBook Pro']

products.each do |product|
  category = Category.find_by_name('Mac')
  # Product.create(name: product, category_id: category.id)
  p = category.products.create!(name: product)
  puts "Product with name #{p.name} just created in category with name #{p.category.name}"
end
