require 'active_support'
require 'active_support/core_ext'

class RecurringMoment
  def initialize(start:, interval:, period:)
    @start = start
    @interval = interval
    @period = period
  end

  def match(date)
    current = @start

    while current <= date  
      if current == date
        return true
      end

      if @period == 'monthly'
        current = current.advance(months: @interval)
        
        if date == date.end_of_month.beginning_of_day
          current = current.end_of_month.beginning_of_day
        elsif date == date.end_of_month.yesterday.beginning_of_day
          current = current.end_of_month.yesterday.beginning_of_day
        end

      elsif @period == 'weekly'
        current = current.advance(weeks: @interval)
      elsif @period == 'daily'
        current = current.advance(days: @interval)
      end
    end

    return false
  end
end


my_date = DateTime.parse("2018-01-31").advance(months: 1)
p my_date.advance(months: 1)
p DateTime.parse("2018-01-31").end_of_month.advance(months: 3)


