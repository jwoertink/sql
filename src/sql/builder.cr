module SQL
  class Builder
    @io : IO
    getter tree : Array(SQL::Component)

    SORTING_ORDER = {
      SQL_Select => 1,
      SQL_From   => 2,
    } of SQL::Component.class => Int32

    def initialize(@io : IO = IO::Memory.new)
      @tree = [] of SQL::Component
    end

    delegate to_s, to: @io

    def add(statement : SQL::Component) : self
      tree << statement
      self
    end

    def build : Nil
      tree.sort_by! { |c| SORTING_ORDER[c.class] }
      tree.each_with_index do |clause, index|
        clause.build(@io)
        @io << " " unless index >= (tree.size - 1)
      end
    end
  end
end
