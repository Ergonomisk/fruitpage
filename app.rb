require 'sinatra'
require 'slim'
require 'sinatra/reloader'
require 'sqlite3'


post('/animals')do

  new_animal = params[:new_animal]
  amount = params[:amount].to_i 
  db = SQLite3::Database.new('db/animals.db')
  db.execute("INSERT INTO animals (name, amount) VALUES (?,?)",[new_animal,amount])
  redirect('/animals')

end

post('/animals/:id/update')do

 #plocka upp id
  id = params[:id].to_i
  name = params[:name]
  amount = params[:amount].to_i

  #kopla till databas
  db = SQLite3::Database.new('db/animals.db')
  db.execute("UPDATE animals SET name=?, amount=? WHERE id=?",[name, amount, id])
  redirect('/animals')

end

#ta bort en djur
post('/animals/:id/delete') do
#Hämta djur
  id = params[:id].to_i
#koppla till databasen
  db = SQLite3::Database.new('db/animals.db')
  db.execute("DELETE FROM animals WHERE id = ?", id)
  
  redirect('/animals')
end


get('/animals') do

  db=SQLite3::Database.new('db/animals.db')
  db.results_as_hash = true
  @databasanimals = db.execute("SELECT * FROM animals")

  p @databasanimals
  slim(:"animals/index")

end

get('/animals/new') do
 slim(:"animals/new")
end


get('/animals/:id/edit')do
  db = SQLite3::Database.new('db/animals.db')
  db.results_as_hash = true
  id = params[:id].to_i
  @special_animal = db.execute("SELECT * FROM animals WHERE id = ?",id).first
  #visa formulär för att uppdatera
  slim(:'animals/edit')

end





#ta bort en frukt
post('/fruitser/:id/delete') do
#Hämta frukter
  id = params[:id].to_i
#koppla till databasen
  db = SQLite3::Database.new('db/fruits.db')
  db.execute("DELETE FROM fruits WHERE id = ?", id)
  
  redirect('/fruitser')
end

get('/fruitser/:id/edit')do
  db = SQLite3::Database.new('db/fruits.db')
  db.results_as_hash = true
  id = params[:id].to_i
  @special_frukt = db.execute("SELECT * FROM fruits WHERE id = ?",id).first
  #visa formulär för att uppdatera
  slim(:'fruits/edit')

end

post('/fruitser/:id/update')do

  #plocka upp id
  id = params[:id].to_i
  name = params[:name]
  amount = params[:amount].to_i

  #kopla till databas
  db = SQLite3::Database.new('db/fruits.db')
  db.execute("UPDATE fruits SET name=?, amount=? WHERE id=?",[name, amount, id])
  #redirect till frutser som har hand om uppvisning
  redirect('/fruitser')
end

get ('/') do
  @banandata="erik"

end

get ('/home') do
  slim(:home)
end

post ('/fruit') do

  new_fruit = params[:new_fruit]
  amount = params[:amount].to_i 
  db = SQLite3::Database.new('db/fruits.db')
  db.execute("INSERT INTO fruits (name, amount) VALUES (?,?)",[new_fruit,amount])
  redirect('/fruitser')

end

get('/fruitser/new') do
 slim(:"fruits/new")
end


get ('/fruitser') do
  db = SQLite3::Database.new("db/fruits.db")
  db.results_as_hash = true
  @datafrukt = db.execute("SELECT * FROM fruits")

  p @datafrukt

  query = params[:q]

  if query && !query.empty?
    @datafrukt =db.execute("SELECT * FROM fruits WHERE name LIKE ?", "%#{query}%")
  else
    @datafrukt = db.execute("SELECT * FROM fruits")
  end

  slim(:"fruits/index")
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




