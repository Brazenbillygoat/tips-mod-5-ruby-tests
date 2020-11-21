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

# my runtime with the below input: =>
# recurrence = RecurringMoment.new(period: "monthly", interval: 3, start: DateTime.parse('Jan 31, 2018'))
# recurrence.match(DateTime.parse('Dec 31, 2018'))

# $ time ruby recurring_moment.rb 
# ruby recurring_moment.rb  0.45s user 0.17s system 99% cpu 0.624 total

# To imporove this method I would like to pull the time out seperately from the 'date'
# variable. As it is now I am assuming the day for monthly periods will always be midnight.
# I could store the time in a variable and put t back on at the start of each iteration.

# I think I would also turn the if elsifs into case whens as they will execute a bit faster.
