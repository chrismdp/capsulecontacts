class SearchesController < ApplicationController
  def new
  end

  def create
    @results = CapsuleContacts.search(params[:q])
    render :results
  end

end
