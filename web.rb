## -*- coding: utf-8 -*-
# 
# Programming Language KQ Reverse Compiler
#
require 'sinatra'
require 'erb'
get '/' do
    erb :index, :locals => {:text =>'Hello KQ Language', :kql => false}
end
require './kqrc'
post '/' do
    buffer = init(params['text'])
    method = params['type']
    case method
    when 'local'
        kql = local(buffer)
    when 'express'
        kql = express(buffer)
    end
    erb :index, :locals => {:text => params['text'], :kql => kql}
end
