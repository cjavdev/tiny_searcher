require 'rails_helper'

RSpec.describe Search do
  it "returns empty list when query is empty" do
    search = Search.new("")
    expect(search.results).to eq([])
    expect(search.errors).to eq([])
  end

  it "adds an error if a field is not supported" do
    search = Search.new("unknown:1")
    expect(search.results).to eq([])
    expect(search.errors).to eq(["Unsupported field `unknown`"])
  end

  it "sets up where clauses for supported fields" do
    search = Search.new("id:1")
    expect(search.where_clauses).to eq({"id" => "1"})
  end

  it "adds name queries for tags and domains if name is a field" do
    search = Search.new("name:thing")
    expect(search.where_clauses).to eq({
      "name" => "thing",
      tags: { name: "thing" },
      domains: { name: "thing" },
    })
  end
end
