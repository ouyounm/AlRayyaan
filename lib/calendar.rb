class Calendar < Struct.new(:view, :date, :callback)

    HEADER = %w[Su M Tu W Th F Sa]
    START_DAY = :sunday

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "calendar" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER.map { |day| content_tag :th, day }.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        content_tag :tr do
          week.map { |day| day_cell(day) }.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      content_tag :td, view.capture(day, &callback), class: day_classes(day)
    end

    def day_classes(day)
      classes = []
      classes << "today" if day == Date.today
      classes << "not-month" if day.month != date.month
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      date = "June 29, 2014".to_date
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      # first = Time.zone.parse("Jun 29, 2014").to_date
      last = date.end_of_month.end_of_week(START_DAY)
      # last = Time.zone.parse("Jul 29, 2014").to_date
      (first..last).to_a.in_groups_of(7)
    end
end
