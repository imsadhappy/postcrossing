module Stats
  # app/models/stats/record_identifiable.rb
  class IdentifiableRecord < Record
    self.abstract_class = true

    class << self
      def of(id)
        @record_type = "#{@record_type_prefix}_#{id}"
        itself
      end

      def record_for(id, day = Date.current)
        of(id).record(day)
      end

      protected

      def after_query
        @record_type = nil
      end
    end
  end
end
