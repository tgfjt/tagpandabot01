# coding: utf-8

require "sinatra"
require "json"

get '/' do
  "Here is tagpandabot01"
end

post '/' do
  content_type :text
  json = JSON.parse(request.body.read)
  json["events"].map{ |e|
    if e["message"]
      "Hi, #{e["message"]["nickname"]}!"
    end
  }.compact.join("\n")+"\n"
end
