# app/controllers/concerns/pagination.rb
module Pagination
  def paginate(collection:, params: {})
    pagination = Pagination::Instance.new(collection, params)

    [
      pagination.metadata,
      pagination.results
    ]
  end
end
