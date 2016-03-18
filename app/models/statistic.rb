class Statistic < ActiveRecord::Base
  
  def self.get_statistics_by_species(alphabet)
    species = Species.where("(del_flag = 1) AND (TRIM(lower(name)) LIKE '#{alphabet.downcase}%')")
    statistic = Array.new
    species.each do |sp|
      stat_by_species = Statistic.where(:species_id => sp.id)
      stat_by_species.each do |stat|
        if (stat != nil)
          statistic.append(stat)
        end
      end
    end
    return statistic
  end
  
  def self.get_statistics_by_families(alphabet)
    statistic = Array.new
    families = Family.where("(del_flag = 1) AND (TRIM(lower(name)) LIKE '#{alphabet.downcase}%')")
    families.each do |family|
      p family.id
      species = Species.where(:family_id => family.id)
      species.each do |sp|
        stat_by_species = Statistic.where(:species_id => sp.id)
        stat_by_species.each do |stat|
          if (stat != nil)
            stat_with_family = [family.name, stat]
            statistic.append(stat_with_family)
          end
        end
      end
    end
    return statistic
  end
  
end
