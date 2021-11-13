# UsersController
class Api::V1::UsersController < Api::V1::ApiApplicationController

  def index
    json = {
              search: Search::SearchPresenter.new.as_json,
              users: UsersPresenter.new(users).as_json,
              current_page: current_page,
              total_pages: @users.total_pages
           }

    render json: json
  end

  def show
    json = UserPresenter.new(user_details).as_json
  
    render json: json
  end

  private

  def users
    @users = User.all
                 .format_pagenation(current_page, USERS_PER_PAGE)
  end

  def user_details
    User.fetch_detail(params[:id])
  end

  def current_page
    page = params[:page].to_i
    page = 1 if page == 0

    page
  end
end
