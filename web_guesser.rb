require 'sinatra'
require 'sinatra/reloader'

secretNumber = rand(100)
get '/' do
  "The SECRET NUMBER is #{secretNumber}!"
end