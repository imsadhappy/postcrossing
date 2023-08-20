module Stats
  # app/models/stats/registrations.rb
  class Registrations < Record
    self.table_name = 'user_stats'

    @record_type = 'registrations'

    class << self
      public :record
    end
  end
end
