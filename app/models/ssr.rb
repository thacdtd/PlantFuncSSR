class Ssr < ActiveRecord::Base
  belongs_to :annotation
  def self.get_SSR_by_species(species_id,
                              ssr_types=nil,
                              no_of_repeat=nil,
                              go_term=nil,
                              itp=nil,
                              motif_size=nil,
                              fdm_annotation=nil)
    ssr = []
    if ssr_types != nil
      where_sql = "ssrs.species_id = " + species_id
      where_sql += " AND ("
      ssr_types.each_with_index do |ssr_type, i|
        where_sql += "(ssrs.SSR_type = '" + ssr_type + "')"
        if ssr_types.length != (i+1)
          where_sql += " OR "
        end
      end
      where_sql += " )"
      if motif_size != nil
        where_sql += " AND (ssrs.size >= " + motif_size +")"
      end
      if fdm_annotation != nil
        where_sql += " AND (ssrs.annotation_id IS NOT NULL)"
      end
      ssr_by_species = Ssr.where(where_sql)
    else
      where_sql = "ssrs.species_id = " + species_id
      if motif_size != nil
        where_sql += " AND (ssrs.size >= " + motif_size +")"
      end
      if fdm_annotation != nil
        where_sql += " AND (ssrs.annotation_id IS NOT NULL)"
      end
      unless go_term.nil?
        where_sql += " AND TRIM(lower(annotations.Goterm)) LIKE '%#{go_term}%'"
      end
      unless itp.nil?
        where_sql += " AND (TRIM(lower(annotations.InterPro)) LIKE '%#{itp}%' )"
      end
      if !go_term.nil? || !itp.nil?
        ssr_by_species = Ssr.joins(:annotation).where(where_sql)
      else
        ssr_by_species = Ssr.where(where_sql)
      end
    end

    if ssr_by_species != nil
      ssr_by_species.each do |s|
        if no_of_repeat != nil
          #check that ssr has number of repeat greater than no_of_repeat
          if s.SSR.split(/[^\d]/).reject { |c| c.empty? }.max.to_i >= no_of_repeat.to_i
            ssr = ssr.append(s)
          end
        else
          ssr = ssr.append(s)
        end
      end
    end
    return ssr
  end

  def self.check_primer(ssr_id)
    _primer1 = Primer1.where(:ssr_id => ssr_id).first
    _primer2 = Primer2.where(:ssr_id => ssr_id).first
    _primer3 = Primer3.where(:ssr_id => ssr_id).first
    if (_primer1 == nil) && (_primer2 == nil) && (_primer3 == nil)
      return false
    end
    return true
  end

  def self.check_annotation(ssr_name)
    _anno = Annotation.where(:name => ssr_name).first
    if _anno != nil
      return true
    end
    return false
  end

end
