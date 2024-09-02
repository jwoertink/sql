module SQL
  abstract struct Component
    abstract def build(io : IO) : Nil
  end
end
