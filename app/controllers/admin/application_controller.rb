class Admin::ApplicationController < ApplicationController
  protect_from_forgery with: :exception

  layout 'admin'

  before_filter :set_locale

  private
  def set_locale
    I18n.locale = I18n.default_locale
  end
end
