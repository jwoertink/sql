require "./sql/*"
require "./sql/components/*"

module SQL
  VERSION = "0.1.0"

  def self.builder : SQL::Builder
    SQL::Builder.new
  end

  def self.union(*builders) : SQL::Builder
    io = IO::Memory.new
    builders.each(&.build)
    builders.map(&.to_s).join(io, " UNION ")
    SQL::Builder.new(io)
  end

  def self.union_all(*builders) : SQL::Builder
    io = IO::Memory.new
    builders.each(&.build)
    builders.map(&.to_s).join(io, " UNION ALL ")
    SQL::Builder.new(io)
  end
end
