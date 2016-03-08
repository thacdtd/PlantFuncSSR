module ApplicationHelper
  def check_active_topbar(controller_name)
    if params[:controller] == controller_name
      return true
    else
      return false
    end
  end
  
  def get_ssr_type_name(id)
    case id
    when "p1"
      return "Mono" 
    when "p2"
      return "Di"
    when "p3"
      return "Tri" 
    when "p4"
      return "Tetra"
    when "p5"
      return "Penta" 
    when "p6"
      return "Hexa"
    when "c"
      return "Complex"
    when "c*"
      return "Compound"
    else
      puts "it was something else"
    end
  end
  
  def reduce_long_string(long_str, str_len)
    if long_str.length > str_len
      return long_str[0,str_len] + "..."
    end
    return long_str
  end
  
  def create_data_cbo(data,options)
    data_cbo = []
    if !options[:select].nil?
      value_default = options[:val].nil? ? 0 : options[:val]
      data_cbo << [options[:select],value_default]
    end
  
    data.each do |item|
      data_cbo << [item[options[:name]],item[options[:id]]]
    end
  
    data_cbo
  end
end
