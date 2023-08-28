module Stats
  # app/models/stats/visits.rb
  class Visits < Record
    self.table_name = 'user_stats'

    @record_type = 'visits'

    class << self
      public :record
    end
  end
end
