module Stats
  # app/models/stats/pageviews.rb
  class Pageviews < IdentifiableRecord
    self.table_name = 'view_stats'

    @record_type_prefix = 'page'
  end
end
