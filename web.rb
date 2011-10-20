## -*- coding: utf-8 -*-
# 
# Programming Language KQ Reverse Compiler
#
require 'sinatra'
require 'erb'
get '/' do
    erb :index, :locals => {:text =>'Hello KQ Language', :kql => false}
end
require './kqlg'
post '/' do
    kq = Kqlg.new(params['text'])
    method = params['type']
    case method
    when 'local'
        kql = kq.local()
    when 'express'
        kql = kq.express()
    end
    erb :index, :locals => {:text => params['text'], :kql => kql}
end
