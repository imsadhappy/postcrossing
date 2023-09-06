module Stats
  # app/models/stats/visits.rb
  class Visits < Record
    @record_type = 'visits'

    class << self
      public :record
    end
  end
end
