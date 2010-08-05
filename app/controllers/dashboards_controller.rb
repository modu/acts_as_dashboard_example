class DashboardsController < ApplicationController
  # NOTE: Remove this line if you don't mind restarting the server after modifying this class.
  include ActsAsDashboard

  acts_as_dashboard

  dashboard_number do |d|
    d.name            = :seconds
    d.title           = 'Seconds This Minute'
    d.update_interval = '5s'
    d.data            {Time.now.strftime '%S'}
  end

  dashboard_short_messages do |d|
    d.name            = :todays_full_date
    d.title           = 'Todays Full Date'
    d.update_interval = '10s'
    d.data            {Time.now.to_s}
  end

  dashboard_line_graph do |d|
    d.name            = :random_dates_and_numbers
    d.title           = 'Random Dates and Numbers'
    d.update_interval = '15s'
    d.line_colours    = %w(blue)
    d.x_axis          = :dates
    d.data do
      (0..10).map do
        year        = Time.now.year
        month       = sprintf '%02d', rand(12) + 1
        day         = sprintf '%02d', rand(31) + 1
        date        = "#{year}-#{month}-#{day}"
        data_point  = rand(20) + 1

        [date, data_point]
      end.to_json
    end
  end
end
