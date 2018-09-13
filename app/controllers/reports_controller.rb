class ReportsController < ApplicationController

  def index
    create
    @occurences = Occurence.all
    set_date
    @report.sort_by! { |occ| occ.device_id }

    @counts = Hash.new 0

    @report.each do |occ|
      @counts[occ.device_id] += 1
    end

    @counts = @counts.sort_by { |key, value| -value }[0..9]

  end

  def create
    file_path = "db/report.csv"
    CSV.foreach(file_path) do |row|
      occurence = Occurence.new(date: row[0], device_id: row[1], device_type: row[2], device_status: row[3])
      occurence.save!
      device = Device.create(id: row[1], type: row[2]) unless Device.select{ |dev| dev.id == row[1] }
    end
  end


  private

  def set_date
    if params[:report_date].present?
      @report = Occurence.select{ |occ| occ.date.to_s == params[:report_date] }
    end
  end

  def set_week_before
    
  end

end
