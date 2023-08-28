# lib/redis_storage.rb
class RedisStorage
  class << self
    def get(key)
      return unless init?

      REDIS.get key
    end

    def set(key, value)
      return unless init?

      REDIS.set key, value
    end

    def del(key)
      return unless init?

      REDIS.del key
    end

    def delall(patter)
      return unless init?

      REDIS.keys(patter).each do |key|
        REDIS.del key
      end
    end

    private

    def init?
      defined? REDIS == 'constant'
    end
  end
end
