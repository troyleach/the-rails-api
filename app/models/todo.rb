class Todo < ApplicationRecord
  # validate :validate_assign_date

  def group_by_assign_date
    # FIXME: this does not take into account timezone
    # Time.zone.at
    assign_date.localtime.to_date
    # assign_date.to_date.to_s(:db)
  end

  private
  def validate_assign_date
    puts 'I am validing the date'
  end
end
