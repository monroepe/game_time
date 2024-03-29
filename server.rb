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
  losses = 0
  record = []
  league.each do |game|
    if game[:home_team] == team
      if game[:home_score] > game[:away_score]
        wins += 1
      else
        losses += 1
      end
    elsif game[:away_team] == team
      if game[:away_score] > game[:home_score]
        wins += 1
      else
        losses += 1
      end
    end
  end
  win_percentage = wins/(wins + losses).to_f
  record << wins
  record << losses
  record << win_percentage
end

def get_records(teams, results)
  records = {}
    teams.each do |team|
      records[team] = get_record(results, team)
    end
  records=records.sort_by{|team, record| -record[0]}
  records.sort_by{|team, record| record[1]}
end

def get_scores(team, league)
  results = []
  league.each do |game|
    if game[:home_team] == team
      results << {opponent: game[:away_team],
      opponent_score: game[:away_score],
      team_score: game[:home_score]}
    elsif game[:away_team] == team
      results << {opponent: game[:home_team],
      opponent_score: game[:home_score],
      team_score: game[:away_score]}
    end
  end
  results
end

teams = get_teams(results)
records = get_records(teams, results)


get '/' do
  #teams = get_teams(results)
  erb :index, locals: {teams: teams}
end

get '/leaderboard' do
  #records = get_records(teams, results)

  erb :leaderboard, locals: {records: records}
end

get '/teams' do
  erb :teams
end

get '/:team' do
  team = params[:team]
  record = get_record(results, params[:team])
  scores = get_scores(params[:team], results)

  erb :'teams/team', locals: {team: team, record: record, scores: scores}
end


