class Collection
  attr_reader :type, :products

  def initialize(type)
    @type = type
    @products = []
  end

  def find_products(options)
    @products.select { |product| (options - product.options.values).empty? }
  end
end
