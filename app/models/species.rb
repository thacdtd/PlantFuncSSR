class Species < ActiveRecord::Base
  def self.get_species_name(species_id)
    return Species.find(species_id).name
  end
end
