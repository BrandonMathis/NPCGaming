class Content::PageController < ApplicationController
  helper_method :authors

  def about_us
    @authors_list = authors
    respond_to do |format|
      format.html
    end
  end

  private
  def authors
    User.all
  end
end
