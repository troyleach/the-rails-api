class Todo < ApplicationRecord
  # validate :validate_assign_date

  def group_by_assign_date
    puts '!* ' * 15
    puts "before modificaiton #{assign_date}"
    puts assign_date.localtime.to_date
    assign_date.localtime.to_date
  end

  private
  def validate_assign_date
    puts 'I am validing the date'
  end
end
