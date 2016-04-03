module ApplicationHelper
  def title(page_title)
    if page_title
      content_for :page_title, page_title.to_s + ' — ' +  t('title')
      content_for :og_title, page_title.to_s
    else
      content_for :page_title, t('title')
      content_for :og_title, t('title')
    end
  end

  def description(page_description)
    content_for :description, page_description.to_s
  end

  def greet
    time = Time.now.in_time_zone('Asia/Yekaterinburg')
    today = Date.today.in_time_zone('Asia/Yekaterinburg').to_time
    morning = today.beginning_of_day
    noon = today.noon
    evening = today.change( hour: 18 )
    night = today.change( hour: 0 )
    message = case time
                when morning..noon
                  'Доброе утро'
                when noon..evening
                  'Добрый день'
                when evening..night
                  'Добрый вечер'
                when night..morning
                  'Приветствую'
              end
    render :text => message
  end
end