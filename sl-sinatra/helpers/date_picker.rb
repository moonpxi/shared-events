module DatePicker
  def week_start
    today = Date.today
    return (today - today.cwday + 1)
  end

  def week_end
    week_start + 6
  end 

  def date_for(string)
    Date.strptime(string, '%m/%d/%Y').to_time
  end
end
