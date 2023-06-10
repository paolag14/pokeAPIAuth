require 'poke-api-v2'

class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def new
    conn = ActiveRecord::Base.connection
    tables = ActiveRecord::Base.connection.tables
    conn.execute("DELETE FROM pokemons") #Resets the database everytime the main page loads
    Rails.application.load_seed 
    
    for a in 1..5 do #Spawns the five pokemon
      x = PokeApi.get(pokemon: rand(1..1010))
      t = []
      for a in 0..(x.types.length-1) do
        #print(x.types[a].type.name)
        t.push(x.types[a].type.name)
      end
      @pokemon = Pokemon.new(name:x.name, pokedex_number:x.id, types: t, sprites: x.sprites.front_default)
      @pokemon.save
    end

    redirect_to action: "index"
  end

  def create #Create not needed because everytime the button is pressed it recreates the whole Team randomly
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
    x = PokeApi.get(pokemon: rand(1..1010)) #Generate random pokemon to update the selected one
    t = []
    for a in 0..(x.types.length-1) do
      #print(x.types[a].type.name)
      t.push(x.types[a].type.name)
    end
    @pokemon.update(name: x.name, pokedex_number:x.id, types: t, sprites: x.sprites.front_default)
    redirect_to @pokemon
  end

  def update
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy

    redirect_to action: "index"
  end

end
