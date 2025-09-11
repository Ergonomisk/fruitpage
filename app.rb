require 'sinatra'
require 'slim'
require 'sinatra/reloader'

get ('/') do
  @banandata="erik"
  slim(:start)
end

get ('/home') do
  slim(:home)
end

get ('/fruits') do
  @fruits =["äpple", "banan", "melon"]
  slim(:fruits)
end

get ('/about') do
  slim(:about)
end

get ('/fruits/:id')do
  fruits =["äpple", "banan", "melon"]
  id = params[:id].to_i
  @fruits =fruits[id]
  slim(:visafrukt)

end



