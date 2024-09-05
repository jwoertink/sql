struct SQL_With < SQL::Component
  STATEMENT = "WITH"

  @parts : Array(String)
  @recursive : Bool

  def initialize(@recursive : Bool = false)
    @parts = [] of String
  end

  def write(name : String, *, as query : SQL::Builder) : Nil
    query.build
    sql = String.build do |io|
      io << name
      if @recursive
        io << "(var)"
      end
      io << " AS (#{query})"
    end

    @parts << sql
  end

  def build(io : IO) : Nil
    if @parts.empty?
      raise SQL::InvalidStatementError.new("At least 1 column was expected. Be sure to write at least 1 column")
    end

    [STATEMENT, (@recursive ? "RECURSIVE " : "")].join(io, " ")
    @parts.join(io, ", ")
  end
end
