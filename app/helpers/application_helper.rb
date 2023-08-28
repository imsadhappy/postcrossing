# app/helpers/application_helper.rb
module ApplicationHelper
  def stats_of(record_type, record_period = 'for_day')
    record_key = "stats_#{record_type}_#{record_period}"
    record = RedisStorage.get record_key
    unless record
      record = Stats.class_eval(record_type.capitalize).send(record_period)
      RedisStorage.set record_key, record
    end
    record
  rescue NoMethodError
    puts 'is Stats record_period correct?'
  rescue NameError
    puts 'is Stats record_type correct?'
  end

  def stats_for(id, record_type, record_period = 'for_day')
    record_key = "stats_#{record_type}_#{id}_#{record_period}"
    record = RedisStorage.get record_key
    unless record
      record = Stats.class_eval(record_type.capitalize).of(id.to_i).send(record_period)
      RedisStorage.set record_key, record
    end
    record
  rescue NoMethodError
    puts 'is Stats record_period correct?'
  rescue NameError
    puts 'is Stats record_type correct?'
  end
end
