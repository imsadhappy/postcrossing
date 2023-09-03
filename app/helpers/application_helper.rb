# app/helpers/application_helper.rb
module ApplicationHelper
  def document_title
    if @page
      @page.title
    elsif @page_title
      @page_title
    else
      t("title.#{controller_name}.#{action_name}")
    end
  end

  def log(msg)
    logger.warn '[' << DateTime.current.to_s << '] ' << msg << ', ' << caller[0]
    nil
  end

  def stats(record_type, record_period = 'for_day')
    record_key = "stats_#{record_type}_#{record_period}"
    record = RedisStorage.get record_key
    unless record
      record = Stats.class_eval(record_type.capitalize).send(record_period)
      RedisStorage.set record_key, record, Time.current.end_of_day
    end
    record
  rescue NoMethodError
    log 'invalid stats record_period, ' << caller[1]
  rescue NameError
    log 'invalid stats record_type, ' << caller[1]
  end

  def stats_for(id, record_type, record_period = 'for_day')
    record_key = "stats_#{record_type}_#{id}_#{record_period}"
    record = RedisStorage.get record_key
    unless record
      record = Stats.class_eval(record_type.capitalize).of(id.to_i).send(record_period)
      RedisStorage.set record_key, record, Time.current.end_of_day
    end
    record
  rescue NoMethodError
    log 'invalid stats record_period, ' << caller[1]
  rescue NameError
    log 'invalid stats record_type, ' << caller[1]
  end
end
