module Stats
  # app/models/stats/record.rb
  class Record < ApplicationRecord
    self.abstract_class = true
    self.table_name = 'stats'

    class << self
      def for_day(day = Date.current)
        for_range day
      end

      def for_month(day = Date.current)
        day = day.to_date
        for_range day.beginning_of_month, day.end_of_month
      end

      def for_year(day = Date.current)
        day = day.to_date
        for_range day.beginning_of_year, day.end_of_year
      end

      def for_range(start_day, end_day = nil)
        record_type_check

        q = 'record_start >= ? AND record_end <= ? AND record_type = ?'
        records = where(q,
                        start_day.to_date.beginning_of_day,
                        (end_day || start_day).to_date.end_of_day,
                        @record_type)
                  .pluck :record_count

        after_query if methods.include? :after_query

        records.sum
      end

      protected

      def record(day = Date.current)
        record_type_check

        record = find_or_create_by! record_args(day)
        record.record_count += 1
        record.save

        RedisStorage.delall "stats_#{@record_type}_*"

        after_record if methods.include? :after_record
        after_query if methods.include? :after_query

        record.record_count
      end

      private

      def record_args(start_day = Date.current, end_day = nil, type = nil)
        {
          record_start: start_day.beginning_of_day,
          record_end: (end_day || start_day).end_of_day,
          record_type: type || @record_type
        }
      end

      def record_type_check
        raise 'undefined record type' unless @record_type
      end
    end
  end
end
