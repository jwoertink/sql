require "./sql/*"
require "./sql/components/*"

module SQL
  VERSION = "0.1.0"

  def self.builder : SQL::Builder
    SQL::Builder.new
  end
end
