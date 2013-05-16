require 'rubygems'
require 'sinatra'
require 'haml'
require 'sequel'
require 'sqlite3'
require 'sanitize'
require './app.rb'

run Sinatra::Application
