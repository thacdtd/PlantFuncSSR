# name_searchable.rb
# mix this into your class using
#   extend NameSearchable
module NameSearchable
  def search_by_prefix (prefix)
    self.where("lower(name) LIKE '#{prefix.downcase}%'")
  end
end