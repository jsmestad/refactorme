class Calendar
  
  def self.find_by_date(date)
    { :year => date.year, :month => date.month, :first_day_of_week => 1, :snippets => Snippet.in_date_range(date).all }
  end

end
