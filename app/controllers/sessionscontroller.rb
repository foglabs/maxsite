class SessionsController < ApplicationController
  
  def create
    @sess = Session.create(code: request.remote_ip)
  end

end