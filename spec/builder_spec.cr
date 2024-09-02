require "./spec_helper"

describe SQL::Builder do
  context "tree" do
    it "writes the components in the correct order" do
      io = IO::Memory.new
      builder = SQL::Builder.new(io)

      select_statement = SQL_Select.new
      select_statement.write("id")
      select_statement.write("name")

      from_statement = SQL_From.new
      from_statement.write("people")

      builder.add(from_statement).add(select_statement)
      builder.build

      builder.to_s.should eq("SELECT id, name FROM people")
    end
  end
end
