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

get '/' do
  teams = get_teams(results)
  erb :index, locals: {teams: teams}
end

get '/leaderboard' do
  erb :leaderboard
end

get '/teams' do
  erb :teams
end

get '/teams/:team' do
  team = params[:team]

  erb :'teams/team', locals: {team: team}
end


