# app/models/stats/base.rb
module Stats
  class Base < ApplicationRecord
    self.abstract_class = true
    self.table_name = 'stats'

    def self.record(day = Date.current)
      record_args = {
        record_start: day.beginning_of_day,
        record_end: day.end_of_day,
        record_type: const_get('RECORD_TYPE')
      }
      record = where(record_args).first_or_create(record_args)
      record.record_count += 1
      record.save
    end

    def self.for_day(day = Date.current)
      for_range(day.beginning_of_day,
                day.end_of_day)
    end

    def self.for_month(day = Date.current)
      for_range(day.beginning_of_month.beginning_of_day,
                day.end_of_month.end_of_day)
    end

    def self.for_year(day = Date.current)
      for_range(day.beginning_of_year.beginning_of_day,
                day.end_of_year.end_of_day)
    end

    def self.for_range(start_day, end_day)
      q = 'record_start >= ? AND record_end <= ? AND record_type = ?'
      t = const_get('RECORD_TYPE')
      where(q, start_day.to_date, end_day.to_date, t).pluck(:record_count).first
    end
  end
end
