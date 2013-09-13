# coding: utf-8

require 'sinatra'

require 'rubygems'
require 'json'
require 'cgi'

json = JSON.parse(CGI.new['json'])
print 'Content-Type: text/plain\n\n'
json['events'].each do |e|
  puts e['message']['text']
end
