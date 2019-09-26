class Product
  attr_reader :options, :id
  attr_accessor :collection_id

  def initialize(id, options)
    @id = id
    @options = options
  end
end
