class SearchService

  def initialize(condition, page, users_per_page)
    @condition = condition
    @page = page
    @users_per_page = users_per_page
  end

  def call
    return result if @condition.present?

    all_users
  end

  private

  def result
    result = @condition.text.present? ? search_text : all_users
    result = result.search_instrument_type(@condition.instrument_type) if @condition.instrument_type.present?

    result
  end

  def search_text
    User.where('nickname LIKE(?) or tweet LIKE(?) or introduction LIKE(?)',
        "%#{@condition.text}%", "%#{@condition.text}%", "%#{@condition.text}%")
        .format_pagenation(@page, @users_per_page)
  end

  def all_users
    User.all.format_pagenation(@page, @users_per_page)
  end
end
