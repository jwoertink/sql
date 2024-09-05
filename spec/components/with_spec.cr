require "../spec_helper"

describe SQL_With do
  it "builds a simple statment" do
    statement = SQL_With.new
    statement.write("reports", as: query)
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq("WITH reports AS (SELECT id, name FROM people)")
  end

  it "builds with recursive" do
    statement = SQL_With.new(recursive: true)
    statement.write("reports", as: query)
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq("WITH RECURSIVE reports(var) AS (SELECT id, name FROM people)")
  end

  it "builds with multiple CTE" do
    statement = SQL_With.new
    statement.write("past_reports", as: query)
    statement.write("future_reports", as: query)
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq("WITH past_reports AS (SELECT id, name FROM people), future_reports AS (SELECT id, name FROM people)")
  end
end

private def query : SQL::Builder
  io = IO::Memory.new
  builder = SQL::Builder.new(io)
  select_statement = SQL_Select.new
  select_statement.write("id")
  select_statement.write("name")
  from_statement = SQL_From.new
  from_statement.write("people")

  builder.add(select_statement).add(from_statement)
end
