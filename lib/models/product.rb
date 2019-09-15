class Product
  attr_reader :options
  attr_accessor :collection

  def initialize(options)
    @options = options
  end
end
