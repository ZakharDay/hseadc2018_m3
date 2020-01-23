Rake::Task['db:drop'].invoke
Rake::Task['db:create'].invoke
Rake::Task['db:migrate'].invoke

# categories = ['Mac', 'iPad', 'iPhone', 'Watch', 'TV', 'Music']

categories = [
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

categories.each do |category|
  c = Category.create!(name: category[:name])
  puts "Category with name #{c.name}"

  category[:products].each do |product|
    p = c.products.create!(name: product)
    puts "Product with name #{p.name} just created in category with name #{p.category.name}"
  end
end
