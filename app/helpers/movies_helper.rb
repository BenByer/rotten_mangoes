module MoviesHelper

  def formatted_date(date)
    begin
      date.strftime("%b %d, %Y")
    rescue
      ""
    end
  end

end
