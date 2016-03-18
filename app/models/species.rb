class Species < ActiveRecord::Base
  def self.get_species_name(species_id)
    #return Species.find(species_id).name
    where_sql = "(del_flag = 1) AND (id = #{species_id})"
    return Species.where(where_sql).first.name
  end
end
