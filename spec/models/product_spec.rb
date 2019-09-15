require 'models/product'

RSpec.describe Product, '#hello' do
  context 'for a new project' do
    it 'greets the world' do
      product = Product.new
      expect(product.hello).to eq 'Hello, world!'
    end
  end
end
