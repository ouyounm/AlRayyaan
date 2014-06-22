class CalendarController < ApplicationController
  def show
    # @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @date = Date.today
  end
end
