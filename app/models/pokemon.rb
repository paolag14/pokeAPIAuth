class Pokemon < ApplicationRecord
    validates :name,:pokedex_number,:types,:sprites, presence:true
end
