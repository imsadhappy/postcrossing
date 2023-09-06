module Stats
  # app/models/stats/registrations.rb
  class Registrations < Record
    @record_type = 'registrations'

    class << self
      public :record
    end
  end
end
