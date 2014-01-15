class Web::ApplicationController < ApplicationController
  protect_from_forgery with: :exception

  layout 'web'

  before_filter :set_locale

  private
  def set_locale
    I18n.locale = I18n.default_locale
  end
end
