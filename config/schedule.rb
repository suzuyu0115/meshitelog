# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/path/to/my/cron_log.log"
ENV.each { |k, v| env(k, v) }
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# 毎日 8:00 にサイトマップを更新
every 1.day, at: '8:00 am' do
  rails 'sitemap:refresh'
end

# Learn more: http://github.com/javan/whenever
