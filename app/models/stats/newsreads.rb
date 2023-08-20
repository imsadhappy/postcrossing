module Stats
  # app/models/stats/newsreads.rb
  class Newsreads < IdentifiableRecord
    self.table_name = 'view_stats'

    @record_type_prefix = 'news'
  end
end
