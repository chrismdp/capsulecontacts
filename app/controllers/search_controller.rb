class SearchController < ApplicationController
  def new
  end

  def search
    @results = CapsuleContacts.search(params[:q])
  end

end
