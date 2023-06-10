class AlterArrays < ActiveRecord::Migration[7.0]
  def change
    change_column :pokemons, :types, :string, array: true
    change_column :pokemons, :sprites, :string, array: true

  end
end
