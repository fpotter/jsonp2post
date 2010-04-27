#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'net/http'
require 'uri'

get '/proxy' do
  request_body = params[:body]
  callback = params[:callback]
  uri = URI.parse(params[:uri])
  
  http = Net::HTTP.new(uri.host, uri.port)
  # http.set_debug_output $stderr  
  request = Net::HTTP::Post.new(uri.path + (uri.query.nil? ? "" : '?' + uri.query), { "Content-Length" => request_body.length.to_s, "Content-Type" => "application/octet-stream" })
  request.body = request_body

  response = http.request(request)

  if response.code.eql?('200')
    content_type "application/javascript"
    return "#{callback}(\"#{response.body}\");"
  else
    response.error!
  end
end