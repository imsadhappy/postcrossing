# lib/redis_storage.rb
class RedisStorage
  class << self
    def fetch(key, exp, force = false)
      value = get key
      unless value || force
        value = yield
        set key, value, exp
      end
      value
    end

    def get(key)
      return unless init?

      REDIS.get key
    end

    def set(key, value, exp = -1)
      return unless init?

      REDIS.set key, value, ex: exp.to_i
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
