module ApplicationHelper
  def title(page_title)
    if page_title
      content_for :page_title, page_title.to_s + ' — ' +  t('title')
      content_for :og_title, page_title.to_s
    else
      page_title
      content_for :page_title, t('title')
      content_for :og_title, t('title')
    end
  end

  def description(page_description)
    content_for :description, page_description.to_s
  end

  def manifest(page_manifest)
    content_for :manifest, page_manifest.to_s
  end
end