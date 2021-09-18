# frozen_string_literal: true

# FIXME: add logging
require 'faraday'
require 'json'

module GetSportScores
  def self.get_scores(league)
    data = Scores.method(league).call
  end

  module Scores
    def self.nfl
      url = "http://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard"
      response = Faraday.get(url, {'Accept' => 'application/json'})
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.mlb
      url = 'http://site.api.espn.com/apis/site/v2/sports/baseball/mlb/scoreboard'
      { :scores => 'for the MLB' }
      response = Faraday.get(url, {'Accept' => 'application/json'})
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.nhl
      # FIXME: I should really make this the only entry point
      # then use the module Teams to get random things from
      # "http://site.api.espn.com/apis/site/v2/sports/#{sport}/#{league}/#{action}"
      # example: action === scoreboard
      url = 'http://site.api.espn.com/apis/site/v2/sports/hockey/nhl/scoreboard'
      response = Faraday.get(url, {'Accept' => 'application/json'})
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end

module Teams
  include App::Teams

  def self.get_all_teams(league)
    url = "https://site.api.espn.com/apis/site/v2/sports/football/#{league}/teams"
    response = Faraday.get(url, {'Accept' => 'application/json'})
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_schedule(year, team, season_type, week)
    url = ""
    response = Faraday.get(url, {'Accept' => 'application/json'})
    JSON.parse(response.body, symbolize_names: true)
    
  end

  def self.get_team(league, team_abb)
    # FIXME: make a Team class
    team_id = TEAMS.find { |obj| obj[team_abb] }[team_abb].to_i
    url = "https://site.api.espn.com/apis/site/v2/sports/football/#{league}/teams/#{team_id}"
    response = Faraday.get(url, {'Accept' => 'application/json'})
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_team_schedule(league, team_abb)
    # FIXME: make a Schedule class
    team_id = TEAMS.find { |obj| obj[team_abb] }[team_abb].to_i
    url = "https://site.api.espn.com/apis/site/v2/sports/football/#{league}/teams/#{team_id}/schedule"
    response = Faraday.get(url, {'Accept' => 'application/json'})
    JSON.parse(response.body, symbolize_names: true)
  end
end
