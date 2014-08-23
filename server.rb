require 'sinatra'
require 'sinatra/reloader'
require 'pry'

results = [
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]

def get_teams(league)
  teams = []
  league.each do |game|
    if !teams.include?(game[:home_team])
      teams << game[:home_team]
    elsif !teams.include?(game[:away_team])
      teams << game[:away_team]
    end
  end
   teams
end

def get_record(league, team)
  wins = 0
  loses = 0
  record = []
  league.each do |game|
    if game[:home_team] == team
      if game[:home_score] > game[:away_score]
        wins += 1
      else
        loses += 1
      end
    elsif game[:away_team] == team
      if game[:away_score] > game[:home_score]
        wins += 1
      else
        loses += 1
      end
    end
  end
  record << wins
  record << loses
  record
end

def get_records(teams, results)
  records = {}
    teams.each do |team|
      records[team] = get_record(results, team)
    end
  records
end

teams = get_teams(results)

get '/' do
  teams = get_teams(results)
  erb :index, locals: {teams: teams}
end

get '/leaderboard' do
  records = get_records(teams, results)

  erb :leaderboard, locals: {records: records}
end

get '/teams' do
  erb :teams
end

get '/teams/:team' do
  team = params[:team]
  record = get_record(results, params[:team])

  erb :'teams/team', locals: {team: team, record: record}
end


