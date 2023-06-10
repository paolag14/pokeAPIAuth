class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :name, :string
    add_column :pokemons, :pokedex_number, :integer
    add_column :pokemons, :types, :text, array: true
    add_column :pokemons, :sprites, :text, array: true
  end
end
