class Api::ApplicationController < ApplicationController
  protect_from_forgery with: :null_session

  layout false

  before_filter :set_locale

  private
  def set_locale
    I18n.locale = I18n.default_locale
  end
end
