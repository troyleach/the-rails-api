class Todo < ApplicationRecord
  # validate :validate_assign_date

  def group_by_assign_date
    puts '!* ' * 15
    puts "before modificaiton #{assign_date}"
    zone = ActiveSupport::TimeZone.new("Central Time (US & Canada)")
    # puts assign_date.localtime.to_date
    # assign_date.localtime.to_date
    date_in_timezone = assign_date.in_time_zone(zone).strftime('%Y-%m-%d')
    puts "after modificaiton #{date_in_timezone}"
    date_in_timezone
  end

  private
  def validate_assign_date
    puts 'I am validing the date'
  end
end
