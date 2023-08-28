# The constant below will represent ONE connection, present globally
# in models, controllers, views etc for the instance. No need to do Redis.new everytime
if defined? Redis == 'constant' && Rails.application.config.redis_options
  REDIS = Redis.new(host: Rails.application.config.redis_options[:host] || 'localhost',
                    port: (Rails.application.config.redis_options[:port] || 6379).to_i)
end
