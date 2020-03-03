class HomeController < ApplicationController
	skip_before_action:logged_in_user
  def top
  end

  def about
  end
end
