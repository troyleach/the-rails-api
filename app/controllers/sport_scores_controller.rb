# frozen_string_literal: true
# make a base controller with the common methods
# then in here do the specific stuff for NFL | NBA | Hockey | baseball
require './lib/api/sports_scores'

class SportScoresController < Base
  include App::Teams
  include GetSportScores

  def index
    # TODO: need to deal with errors or the wrong key
    # fixme: api should just return all the leauges
    # make route for each league
    league = request.headers['x-league']
    data = GetSportScores.get_scores(league)
    formated_data = build_payload(data)

    render json: formated_data, status: 200
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

end
