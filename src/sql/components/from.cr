struct SQL_From < SQL::Component
  STATEMENT = "FROM"

  @parts : Array(String)

  def initialize
    @parts = [] of String
  end

  def write(name : String, *, as alias_name : String? = nil) : Nil
    alias_name.try do |a_name|
      name = "#{name} AS #{a_name}"
    end
    @parts << name
  end

  def build(io : IO) : Nil
    if @parts.empty?
      raise SQL::InvalidStatementError.new("At least 1 table was expected. Be sure to write at least 1 table")
    end

    io << STATEMENT
    io << " "
    @parts.join(io, ", ")
  end
end
