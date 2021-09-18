# frozen_string_literal: true
# make a base controller with the common methods
# then in here do the specific stuff for NFL | NBA | Hockey | baseball
require './lib/api/sports_scores'

class SportScoresController < Base
  include App::Teams
  include GetSportScores

  def index
    # TODO: need to deal with errors or the wrong key
    league = request.headers['x-league']
    data = GetSportScores.get_scores(league)
    formated_data = build_payload(data)
    date = formated_data[0][:date]

    # Time.parse(formated_data.last[:date]).to_date
    
    # Time.zone.parse("2010-01-01 12:30:00").utc

    # schedules_by_date = formated_data.group_by { |schedule| Time.zone.parse(schedule[:date]).utc }
    # schedules_by_date = formated_data.group_by { |schedule| Time.parse(schedule[:date]).to_date }
    # Time.parse(date).utc.in_time_zone('Mountain Time (US & Canada)')
    # Time.parse(schedule[:date]).utc.in_time_zone('Mountain Time (US & Canada)')
    # this works below ===== ugly shit
    # schedules_by_date = formated_data.group_by { |schedule| Time.parse(schedule[:date]).utc.in_time_zone('Mountain Time (US & Canada)').to_date }
    schedules_by_date = formated_data.group_by { |schedule| Time.parse(schedule[:date]).utc.in_time_zone('Mountain Time (US & Canada)') }
      # .sort_by { |date| date.itself  }
    

    render json: formated_data, status: 200
    # render json: schedules_by_date, status: 200
  end

  def get_date(date_string)
    Time.parse(schedule[:date])
  end

  def show
  end

  def teams
    league = request.headers['x-league']
    team_abb = request.headers['x-team'].upcase
    team = Teams.get_team(league, team_abb)
    # FIXME: deal with errors
    render json: team, status: 200
  end

  def schedule
    league = request.headers['x-league']
    team_abb = request.headers['x-team'].upcase
    schedule = Teams.get_team_schedule(league, team_abb)
    # FIXME: deal with errors
    render json: schedule, status: 200
  end

  def create; end


  def destroy; end

end
