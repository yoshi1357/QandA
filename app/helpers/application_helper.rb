module ApplicationHelper

  def set_title(page_title = "")
    base_title = "わいわいみんなのQ&Aサイト!"
    page_title.empty? ? base_title : page_title+" | "+base_title
  end

  def simple_time(japan_time)
    japan_time.strftime("%Y-%m-%d %H:%M")
  end

end
