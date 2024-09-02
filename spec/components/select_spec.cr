require "../spec_helper"

describe SQL_Select do
  it "builds simple columns" do
    statement = SQL_Select.new
    statement.write("id")
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq("SELECT id")
  end

  it "builds column with table name" do
    statement = SQL_Select.new
    statement.write("users.id")
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq("SELECT users.id")
  end

  it "builds quoted column with table name" do
    statement = SQL_Select.new
    statement.write("users.id", quote: true)
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq(%(SELECT "users"."id"))
  end

  it "builds quoted column without table name" do
    statement = SQL_Select.new
    statement.write("order", quote: true)
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq(%(SELECT "order"))
  end

  it "builds multiple columns" do
    statement = SQL_Select.new
    statement.write("users.id")
    statement.write("users.order", quote: true)
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq(%(SELECT users.id, "users"."order"))
  end

  it "builds the star" do
    statement = SQL_Select.new
    statement.write(SQL_Select::STAR)
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq(%(SELECT *))
  end

  it "does not quote the star" do
    statement = SQL_Select.new
    statement.write(SQL_Select::STAR, quote: true)
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq(%(SELECT *))
  end

  it "builds with an alias column name" do
    statement = SQL_Select.new
    statement.write("reports.combined_totals", as: "totals")
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq(%(SELECT totals))
  end

  it "builds with an alias quoted column name" do
    statement = SQL_Select.new
    statement.write("reports.location", quote: true, as: "from")
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq(%(SELECT "from"))
  end

  # TODO: Come back to this one
  # it "still quotes columns inside of a function" do
  #   statement = SQL_Select.new
  #   statement.write("COUNT(posts.*)", quote: true)
  #   io = IO::Memory.new
  #   statement.build(io)
  #   io.to_s.should eq(%(SELECT COUNT("posts".*)))
  # end

  it "doesn't write empty strings" do
    statement = SQL_Select.new
    statement.write("id")
    statement.write("")
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq(%(SELECT id))
  end

  it "raises an exception when there's nothing to build" do
    statement = SQL_Select.new
    io = IO::Memory.new
    expect_raises(SQL::InvalidStatementError) do
      statement.build(io)
    end
  end
end
