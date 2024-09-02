require "../spec_helper"

describe SQL_From do
  it "builds simple statement" do
    statement = SQL_From.new
    statement.write("users")
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq("FROM users")
  end

  it "builds with an alias name" do
    statement = SQL_From.new
    statement.write("users", as: "u")
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq("FROM users AS u")
  end

  it "builds with multiple table names" do
    statement = SQL_From.new
    statement.write("users", as: "u")
    statement.write("posts", as: "p")
    io = IO::Memory.new
    statement.build(io)
    io.to_s.should eq("FROM users AS u, posts AS p")
  end

  it "raises an exception when there's nothing to build" do
    statement = SQL_From.new
    io = IO::Memory.new
    expect_raises(SQL::InvalidStatementError) do
      statement.build(io)
    end
  end
end
