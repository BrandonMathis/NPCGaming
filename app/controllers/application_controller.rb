class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

  def textile_ref
    File.open(Rails.root.join("lib", "textile_ref.txt"))
  end
end
