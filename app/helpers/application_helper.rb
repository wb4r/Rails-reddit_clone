module ApplicationHelper
  def check_and_fix_url(url)
    binding.pry
  end

  def display_datetime(dt)
    Time.zone = "Edinburgh"
    dt.strftime("%d/%m/%Y %l:%M%P %Z") # 03/14/2014 9:09pm
    
  end
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-warning"
    when :alert then "alert alert-danger"
    end
  end
end
