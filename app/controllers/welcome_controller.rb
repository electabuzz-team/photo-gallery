class WelcomeController < ApplicationController
  before_action :skip_if_logged_in

  def index
  end
end
