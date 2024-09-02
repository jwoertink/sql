require "./spec_helper"

describe SQL do
  describe ".union" do
    it "combines 2 queries" do
      query1 = SQL.builder
      select1 = SQL_Select.new
      select1.write("id")
      from1 = SQL_From.new
      from1.write("transactions")
      query1.add(select1).add(from1)

      query2 = SQL.builder
      select2 = SQL_Select.new
      select2.write("id")
      from2 = SQL_From.new
      from2.write("reports")
      query2.add(select2).add(from2)

      SQL.union(query1, query2).to_s.should eq("SELECT id FROM transactions UNION SELECT id FROM reports")
    end
  end

  describe ".union_all" do
    it "combines 2 queries" do
      query1 = SQL.builder
      select1 = SQL_Select.new
      select1.write("id")
      from1 = SQL_From.new
      from1.write("transactions")
      query1.add(select1).add(from1)

      query2 = SQL.builder
      select2 = SQL_Select.new
      select2.write("id")
      from2 = SQL_From.new
      from2.write("reports")
      query2.add(select2).add(from2)

      SQL.union_all(query1, query2).to_s.should eq("SELECT id FROM transactions UNION ALL SELECT id FROM reports")
    end
  end
end
