class OccurencesController < ApplicationController

    def index
      @occurences = Occurence.all
      set_date
    end

    def new
      create
    end

    def create
      Occurence.delete_all
      file_path = "db/report.csv"
      CSV.foreach(file_path) do |row|
        occurence = Occurence.new(date: row[0], device_id: row[1], device_type: row[2], device_status: row[3])
        occurence.save!
      end
      redirect_to occurences_path
    end

    def overview
      set_days
    end

    private

    def set_date
      if params[:report_date].present?
        @report = Occurence.select{ |occ| occ.date.to_s == params[:report_date] }
        @counts = Hash.new 0
        @report.each do |occ|
          @counts[occ.device_id] += 1
        end
        @counts = @counts.sort_by { |key, value| -value }[0..9]
      end
    end

    def set_days
      if params.present?
        @occurences = Occurence.select { |o| o.device_type == params[:type] && o.device_status == params[:status] && o.date >= Date.today.prev_day(30)}
        @days = Hash.new 0
        @occurences.each do |o|
          @days[o.date] += 1
        end
      end
    end

end
