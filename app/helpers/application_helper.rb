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
    time = Time.now.in_time_zone('Ekaterinburg').to_i
    today = Date.today.in_time_zone('Ekaterinburg')
    morning = today.beginning_of_day.to_i
    noon = today.noon.to_i
    evening = today.change( hour: 18 ).to_i
    night = today.change( hour: 0 ).to_i
    message = case time
                when morning..noon
                  t('greeting.good_morning')
                when noon..evening
                  t('greeting.good_day')
                when evening..night
                  t('greeting.good_evening')
                when night..morning
                  t('greeting.welcome')
                else
                  t('greeting.welcome')
              end
    render :text => message
  end
end