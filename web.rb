# coding: utf-8

require "sinatra"
require "json"

post "/hi" do
  j = JSON.parse(request.body.string)
  j["events"].map{ |e|
    if e["message"]
      "Hi, #{e["message"]["nickname"]}!"
    end
  }.compact.join("\n")+"\n"
end
