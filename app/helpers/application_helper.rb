# app/helpers/application_helper.rb
module ApplicationHelper
  def document_title
    @document_title || t("title.#{controller_name}.#{action_name}")
  end

  def log(msg)
    logger.warn '[' << DateTime.current.to_s << '] ' << msg << ', ' << caller[0]
    nil
  end

  def stats(record_type, record_period = 'for_day')
    RedisStorage.fetch "stats_#{record_type}_#{record_period}",
                       (Time.current.end_of_day - Time.current).round do
      Stats.class_eval(record_type.capitalize).send(record_period)
    end
  rescue NoMethodError
    log 'invalid stats record_period, ' << caller[1]
  rescue NameError
    log 'invalid stats record_type, ' << caller[1]
  end

  def stats_for(id, record_type, record_period = 'for_day')
    RedisStorage.fetch "stats_#{record_type}_#{id}_#{record_period}",
                       (Time.current.end_of_day - Time.current).round do
      Stats.class_eval(record_type.capitalize).of(id.to_i).send(record_period)
    end
  rescue NoMethodError
    log 'invalid stats record_period, ' << caller[1]
  rescue NameError
    log 'invalid stats record_type, ' << caller[1]
  end
end
