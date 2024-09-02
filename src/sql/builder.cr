module SQL
  class Builder
    @io : IO
    getter tree : Array(SQL::Component)

    def initialize(@io : IO = IO::Memory.new)
      @tree = [] of SQL::Component
    end

    delegate to_s, to: @io
  end
end
