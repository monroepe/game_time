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

def get_teams
  teams = []
  results.each do |game|
    if !teams.include?(:home_team)
      teams << :home_team
    elsif !teams.include?(:away_team)
      teams << away_team
    end
   teams
end

get '/' do
  erb :index
end

get '/leaderboard' do
  erb :leaderboard
end

get '/leaderboard/:team' do

end

get '/teams' do
  erb :teams
end

get '/teams/:team' do

end


