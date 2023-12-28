# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?
  NAME = %i[user super_admin subscriber].freeze

  NAME.each do |name|
    Role.find_or_create_by!(name: name)
  end

  DEFAUT_MOVIE_GENRES = [
    'Action',
    'Anime',
    'Classique',
    'Comedies',
    'Documenttaires',
    'Drames',
    'Horror',
    'Romance',
    'Crime',
    'African',
    'Science fiction',
  ]

  DEFAUT_MOVIE_GENRES.each do |genre_name|
    MovieGenre.find_or_create_by!(name: genre_name)
  end

  # DEFAUT_GENRES_OF_MUSIC = [
  #   'Classical',
  #   'Love',
  #   'Religious',
  #   'Rock',
  #   'Instrumental'
  # ]
end

AdminUser.create!(email: 'admin@gmail.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
# AdminUser.find_or_create_by!(email: 'admin@gmail.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
# domoda, 