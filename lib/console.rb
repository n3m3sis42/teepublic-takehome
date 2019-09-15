class Console
  attr_reader :product_type, :options

  def initialize()
    args = ARGV
    @product_type = args[0]
    @options = args[1..-1]
  end
end
