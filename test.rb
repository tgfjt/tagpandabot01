# -*- coding : utf-8 -*-
require "sinatra"
require "json"
require "open-uri"
require 'open3'
 
get '/' do
  "aaa"
end
 
post '/' do
  content_type :text
  event = JSON.parse(open("http://api.atnd.org/events/?event_id=33746&format=json").read)
  json = JSON.parse(request.body.string)
  url = [] 
  title = []
  date = []
  author = []
  count = []
  counter = 0
  json["events"].map{|e|
    if e["message"]
      m = e["message"]["text"]
      if /^!VimAdv/ =~ m
        command = m.strip.split(/[\s　]/)
        event["events"][0]["description"].gsub(/\|(.*)\|(.*)\|(.*)\|"(.*)":(.*)\|/){
          count << $1
          date << $2
          author << $3
          title << $4
          url << $5
        }
        if command[1] == nil 
          return "#{count.reverse[0]} #{date.reverse[0]} #{author.reverse[0]} #{title.reverse[0]} - #{url.reverse[0]}"
        elsif command[1] =~ /^\d+/
          return "#{count[command[1].to_i-1]} #{date[command[1].to_i-1]} #{author[command[1].to_i-1]} #{title[command[1].to_i-1]} - #{url[command[1].to_i-1]}"
        elsif command[1] =~ /^(.*)/
          author.each do |a|
            if a == command[1]
              counter+=1
            end
          end
          return "#{command[1]} was written #{counter} times."
        end
      elsif /^:help/ =~ m
        help = m.strip.split(/[\s　]/)
        Open3.popen3("vim") do |si,so,se,th|
          si.puts "--cmd \"so help.vim\" #{help[1]}"
          return se.read.gsub(/.*への.*\n/,"")
        end
      end
    end
  }
end
