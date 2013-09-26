# coding: utf-8

require 'sinatra'
require 'json'

get '/' do
  'Here is tagpandabot01'
end

post '/' do
  content_type :text
  json = JSON.parse(request.body.read)
  json['events'].select { |e| e['message'] }.map { |e|
    text = e['message']['text']
    if e['message']
      text + '!'
    end
  }.compact.join('\n') + '\n'
end
