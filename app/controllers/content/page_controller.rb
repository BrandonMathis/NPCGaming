class Content::PageController < ApplicationController
  def about_us
    respond_to do |format|
      format.html
    end
  end
end
