# coding: utf-8

require 'sinatra'
require 'net/http'
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
      if /^!bestsong/ =~ text
        text =  text.strip.split(/[\s　]/)
        artist = text[1]

        url = 'http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&format=json&artist='
        apikey = '&api_key=8b8d4214382f1f7c31873276e3a60d39'
        limit = '&limit=1'

        uri = URI.parse(url + artist + apikey + limit)
        json = Net::HTTP.get(uri)
        result = JSON.parse(json)

        songname = result['toptracks']['track']['name']
        imageL = result['toptracks']['track']['image'][3]['#text']

        message = 'the best song of #{artist} is #{songname}!' + '\n'
        message + imageL
      end
    end
  }.join
end
