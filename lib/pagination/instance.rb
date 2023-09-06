# lib/pagination/instance.rb
module Pagination
  class Instance
    attr_reader :collection, :params

    def initialize(collection, params = {})
      @collection = collection
      @params = params.merge(count: collection.size)
    end

    def metadata
      @metadata ||= Pagination::Metadata.new(params)
    end

    def results
      collection.limit(metadata.per_page).offset(metadata.offset)
    end
  end
end
