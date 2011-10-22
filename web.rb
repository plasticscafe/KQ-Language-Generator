## -*- coding: utf-8 -*-
# 
# Programming Language KQ Reverse Compiler
#
require 'sinatra'
require 'erb'

require './kqlg'

get '/' do
    erb :index, :locals => {:pre_text => 'Hello KQ Language', :text => '', :kql => false}
end

post '/' do
    kq = Kqlg.new(params['text'])

    # use send method. instted of branch code
    # if called unimplemented method. Kqlg class return method_missing() result : always return nil.
    kql = kq.send(params['type'].to_sym)
    
    # TODO flash message or if kql.nil?
    
    erb :index, :locals => {:pre_text => 'Hello KQ Language', :text => params['text'], :kql => kql}
end
