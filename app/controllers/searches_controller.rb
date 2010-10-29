class SearchesController < ApplicationController
  def new
  end

  def search
    @results = CapsuleContacts.search(params[:q])
    render :results
  end

end
