# config/initializers/redis.rb
REDIS_CLIENT = Redis.new(host: 'localhost', port: 6379, db: 1)