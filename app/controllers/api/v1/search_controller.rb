class Api::V1::SearchController < ApplicationController

  # example: http://localhost:8080/api/v1/search?page=1&text=test,fuga
  def index
    json = {
      search: Search::SearchPresenter.new.as_json,
      users: UsersPresenter.new(search_result).as_json,
      current_page: current_page,
      total_pages: @users.total_pages
    }

    render json: json
  end

  private

  def search_result
    @users = SearchService.new(condition, params[:page], USERS_PER_PAGE)
                 .call
  end

  def condition
    @condition = SoundsFetch::Search::Conditioner.new(params)
  end

  def current_page
    page = params[:page].to_i
    page = 1 if page == 0

    page
  end
end
