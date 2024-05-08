# app/controllers/concerns/pagination.rb
# Thanks to Ana Nunes da Silva @anakbns for tutorial:)
# https://www.ananunesdasilva.com/posts/pagination-in-rails-from-scratch-no-gems
module Pagination
  extend ActiveSupport::Concern

  included do
    before_action :paginate, only: %i[index]
    helper_method :pagination_path
  end

  def paginate
    return unless paginated_collection && pagination_settings

    pagination = Pagination::Instance.new(paginated_collection, pagination_settings)
    @collection = pagination.results
    @pagination = pagination.settings
  end

  def pagination_path(page = 1)
    return request.path if page == 1

    request.path << '?' << { page: }.to_query
  end

  # app/controllers/concerns/pagination.rb
  class Instance
    attr_reader :collection, :params

    def initialize(collection, params = {})
      @collection = collection
      @params = params.merge(count: collection.size)
    end

    def settings
      @settings ||= Pagination::Settings.new(params)
    end

    def results
      collection
        .limit(settings.per_page)
        .offset(settings.offset)
        # maybe orderby too?
    end
  end

  # app/controllers/concerns/pagination.rb
  class Settings
    DEFAULT = { page: 1, per_page: 10 }.freeze

    attr_reader :page, :count, :per_page

    def initialize(params = {})
      @page     = (params[:page] || DEFAULT[:page]).to_i
      @count    = params[:count]
      @per_page = params[:per_page] || DEFAULT[:per_page]
    end

    def offset
      return 0 if page == 1

      per_page * (page.to_i - 1)
    end

    def next_page
      page + 1 unless last_page?
    end

    def next_page?
      page < total_pages
    end

    def previous_page
      page - 1 unless first_page?
    end

    def previous_page?
      page > 1
    end

    def last_page?
      page == total_pages
    end

    def first_page?
      page == 1
    end

    def total_pages
      (count / per_page.to_f).ceil
    end

    def exists?
      total_pages.positive?
    end
  end
end
