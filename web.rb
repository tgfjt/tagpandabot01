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
      if /^!tagpanda/ =~ text
        text =  text.strip.split(/[\s　]/)
        'tagpanda says: ' + text[1] + '!'
      end
    end
  }.join
end
