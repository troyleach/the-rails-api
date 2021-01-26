class Todo < ApplicationRecord
  # validate :validate_assign_date

  def group_by_assign_date
    # get all timezones
    # ActiveSupport::TimeZone.us_zones.map(&:name)
    # ["America/Adak", "Hawaii", "Alaska", "America/Anchorage", "America/Metlakatla", "America/Nome", "America/Sitka", "America/Yakutat", "Pacific Time (US & Canada)", "America/Boise", "Arizona", "Mountain Time (US & Canada)", "America/Indiana/Knox", "America/Indiana/Tell_City", "America/Menominee", "America/North_Dakota/Beulah", "America/North_Dakota/Center", "America/North_Dakota/New_Salem", "Central Time (US & Canada)", "America/Detroit", "America/Indiana/Marengo", "America/Indiana/Petersburg", "America/Indiana/Vevay", "America/Indiana/Vincennes", "America/Indiana/Winamac", "America/Kentucky/Louisville", "America/Kentucky/Monticello", "Eastern Time (US & Canada)", "Indiana (East)"]
    # this did work in the console of chrome
    # Intl.DateTimeFormat().resolvedOptions().timeZone => 'America/Chicago'
    # and ran the code below in the heorku console and it seemed to work
    # funny, I was converting the date to the local time... local time of the server.
    # instead of the local time of the person make the todo.
    # TODO:
    # - I need to somehow pass the time zone now.. this sucks but it is what it is at this point bc of the way I set up the flow. Maybe think about this a bit
    # - then convert the date and group_by date.
    # maybe this was not the best way to do this...
    puts '!* ' * 15
    puts "before modificaiton #{assign_date}"
    zone = ActiveSupport::TimeZone.new("Central Time (US & Canada)")
    # puts assign_date.localtime.to_date
    # assign_date.localtime.to_date

    # if this is just a normal todo, not part of scrum
    return 'todos' if assign_date.nil?

    date_in_timezone = assign_date.in_time_zone(zone).strftime('%Y-%m-%d')
    puts "after modificaiton #{date_in_timezone}"
    date_in_timezone
  end

  private

  def validate_assign_date
    puts 'I am validing the date'
  end
end
