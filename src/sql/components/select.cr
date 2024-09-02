struct SQL_Select < SQL::Component
  STATEMENT = "SELECT"
  STAR      = "*"

  @parts : Array(String)

  def initialize
    @parts = [] of String
  end

  def write(field : String, *, quote : Bool = false, as alias_name : String? = nil) : Nil
    field.presence.try do |column|
      field = alias_name || column
      if quote
        field = field.split('.').join('.') do |data|
          if data == STAR
            data
          else
            %("#{data}")
          end
        end
      end

      @parts << field
    end
  end

  def build(io : IO) : Nil
    if @parts.empty?
      raise SQL::InvalidStatementError.new("At least 1 column was expected. Be sure to write at least 1 column")
    end

    io << STATEMENT
    io << " "
    @parts.join(io, ", ")
  end
end
