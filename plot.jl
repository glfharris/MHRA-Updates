# using PyCall
# using Requests

# @pyimport loader

# data = loader.load()

# print(data)

using JSON, Requests, Gadfly, Dates, PyCall

@pyimport loader

tmp = loader.load()
print(tmp)

data = get("https://openprescribing.net/api/1.0/spending", query=Dict("format" => "json", "code" => "0212000B0AA")).data |> String |> JSON.parse

items = []
dates = []
for x in data
    try
        push!(items, x["items"])
        push!(dates, Dates.Date(x["date"], "y-m-d"))
    end
end

plot(x=dates, y=items, Geom.line)