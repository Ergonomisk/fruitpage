require 'sinatra'
require 'slim'
require 'sinatra/reloader'

get ('/') do
  @banandata="erik"

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

get('/fruktinfo')do
  @fruktinfo = [ 
      {
        "namn" => "Bruten_fo",
        "vikt" => "4kg",
        "färg" => "blå"
      }, 
      {
        "namn" => "kaled",
        "vikt" => "7kg",
        "färg" => "röd"
      }
    ]
    slim(:fruktinfo)
end




