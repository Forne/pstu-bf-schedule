module ApplicationHelper
  def title(page_title)
    if page_title
      content_for :title, page_title.to_s + ' | Расписание БФ ПНИПУ'
    else
      content_for :title, 'Расписание БФ ПНИПУ'
    end
  end
end