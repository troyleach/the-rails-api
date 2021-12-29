# frozen_string_literal: true
# make a base controller with the common methods
# then in here do the specific stuff for NFL | NBA | Hockey | baseball

# FIXME: after thinking about this, this really is not a good place for these methods
class Base < ApplicationController
  def build_payload(data)
    events = data[:events]
    # TODO: need to get the week, like week: 1
    # FIXME: should not do this first thing event[:competitions].first[:competitors]
    data[:events].map do |event|
      {
        :id => event[:id],
        :date => event[:date],
        :name => event[:name],
        :shortName => event[:shortName],
        :year => event[:season][:year],
        :competitors => get_competitors(event[:competitions]&.first[:competitors]),
        # :broadcasts => event[:competitions].first[:broadcasts].first[:names].first
        # :broadcasts => event[:competitions].first[:broadcasts].map { |networks| networks.names }
        :broadcasts => get_broadcasts(event[:competitions]&.first[:broadcasts])
      }
    end
  end

  def get_competitors(teams)
    # this is super fragile. team[:records] did not exist bombed the hole thing
    # FIXME: should not do this first thing team[:team][:links]&.first[:href]
    teams.map do |team|
      {
        :id => team[:id],
        :homeAway => team[:homeAway],
        :name => team[:team][:name],
        :displayName => team[:team][:displayName],
        :abbreviation => team[:team][:abbreviation],
        :href => team[:team][:links]&.first[:href],
        :logo => team[:team][:logo],
        :score => team[:score],
        :records => team[:records] && team[:records].first[:summary]
      }
    end
  end

  def get_broadcasts(broadcasts)
    return 'Unknown' if broadcasts.empty?
    broadcasts.first[:names].first
  end
:w

end
