require_relative 'data'

#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

AdminUser.create!(email: 'admin@gmail.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

if Rails.env.development?

  # CreateRoles
  ROLE_NAMES.each do |name|
    Role.find_or_create_by!(name: name)
  end
  # ROLE_NAMES.each { |name| Role.find_or_create_by!(name) }
  
  puts "=====> Create Genres"
  DEFAUT_MOVIE_GENRES.each do |genre_name|
    MovieGenre.find_or_create_by!(name: genre_name)
  end

  puts "=====> Create Videos"
  VIDEOS_MOVIES.each do |video|
    Video.find_or_create_by!(video)
  end


  RANGE = (10..1000).to_a.freeze

  puts "=====> Create MovieWritters"

  (1..20).each do |writter|
    # binding.pry
    MovieWritter.create!(
      avatar_url: "https://i.pravatar.cc/#{RANGE.sample}",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      # date_of_birth: Faker::Date.between(from: 2.days.ago, to: Date.today),
      date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 65),
      personal_details: {
        address: Faker::Address.full_address, #=> "282 Kevin Brook, Imogeneborough, CA 58517"
        bio: Faker::Lorem.paragraph(sentence_count: 3, supplemental: false, random_sentences_to_add: 4),
        email_address: Faker::Internet.email,
        sex: Faker::Gender.short_binary_type, #=> "f" # Faker::Gender.binary_type #=> "Female"
        # interests: INTERESTS[(1..INTERESTS.size).to_a.sample][:name],
        interests: ['Music', 'Sport', 'Reading', 'Travel'],
        languages: Faker::Nation.language
      },
      status: rand(0..2)
    )
  end

   puts "=====> Create Outcasts"

  (1..30).each do |outcast|
    Outcast.create!(
      avatar_url: Faker::Avatar.image(slug: Faker::Name.name, size: '50x50', format: 'jpg'),
      # Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "bmp", set: "set1", bgset: "bg1")
      #=> "https://robohash.org/my-own-slug.bmp?size=50x50&set=set1&bgset=bg1"
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      date_of_birth: Faker::Date.between(from: 2.days.ago, to: Date.today),
      # date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 65),
      personal_details: {
        address: Faker::Address.full_address,
        bio: Faker::Lorem.paragraph(sentence_count: 3),
        email_address: Faker::Internet.email,
        sex: Faker::Gender.short_binary_type, #=> "f"
        interests: Faker::Lorem.sentence(word_count: 3),
        languages: ['English', 'Frensh', 'Spanish']
      },
      status: rand(0..2)
    )
  end

  puts "=====> Create Movies"

  (1..20).each do |movie|
    Movie.create!(
      name: Faker::Movie.unique.title,
      description: Faker::Lorem.paragraph(sentence_count: 3),
      category: 1,
      image_url: Faker::Avatar.image(slug: Faker::Name.name, size: '50x50', format: 'jpg'),
      # released_at: Faker::Date.between(from: 2.days.ago, to: Date.today),
      released_at: Faker::Movies::Avatar.date,
      content_details: {
        country: Faker::Address.country, #=> "French Guiana"
        duration: '2h 16m',
        original_language: Faker::Nation.language
      },
      status: rand(0..2),
      movie_genre_id: rand(1..DEFAUT_MOVIE_GENRES.size),
      video_link_id: rand(1..3),
      trailer_link_id: rand(3..VIDEOS_MOVIES.size),
      movie_writter_id: rand(1..15),
      # movie_outcast_id: rand(1..30)
    )
  end

  puts "=====> Create Series"

  (1..20).each do |serie|
    Serie.create!(
      name: Faker::Movie.unique.title,
      description: Faker::Lorem.paragraph(sentence_count: 3),
      category: 1,
      image_url: Faker::Avatar.unique.image(slug: Faker::Name.name, size: '50x50', format: 'jpg'),
      content_details: {
        country: Faker::Address.country, #=> "French Guiana"
        original_language: Faker::Nation.language
      },
      status: rand(0..2),
      movie_genre_id: rand(1..DEFAUT_MOVIE_GENRES.size),
      video_link_id: rand(1..VIDEOS_MOVIES.size),
      movie_writter_id: rand(1..15),
      # movie_outcast_id: rand(1..30)
    )
  end
  
  puts "=====> Create Seasons"

  Serie.all.each do |serie|
    existing_seasons_count = serie.seasons.size

    (1..rand(1..5)).each do |season_number|
      Season.create!(
        title: "Season #{existing_seasons_count + season_number}",
        description: Faker::Lorem.paragraph(sentence_count: 3),
        image_url: Faker::Avatar.unique.image(slug: Faker::Name.name, size: '50x50', format: 'jpg'),
        released_at: Faker::Movies::Avatar.date,
        status: rand(0..2),
        video_link_id: rand(1..VIDEOS_MOVIES.size),
        episods_counter: rand(1..20),
        serie_id: serie.id
      )
    end
  end

  puts "=====> Create Episodes"

  Season.all.each do |season|
    existing_episodes_count = season.episodes.size

    (1..rand(1..9)).each do |episode_number|
      Episode.create!(
        name: "Episode #{existing_episodes_count + episode_number}",
        description: Faker::Lorem.paragraph(sentence_count: 3),
        image_url: Faker::Avatar.unique.image(slug: Faker::Name.name, size: '50x50', format: 'jpg'),
        released_at: Faker::Movies::Avatar.date,
        duration: '2h 16m',
        status: rand(0..2),
        video_link_id: rand(1..VIDEOS_MOVIES.size),
        trailer_link_id: rand(1..VIDEOS_MOVIES.size),
        season_id: season.id,
        serie_id: season.serie_id
        # serie_id: season.serie.id
      )
    end
  end


  puts "=====> Create Artists"

  (1..10).each do |artist|
    Artist.create!(
      avatar_url: "https://i.pravatar.cc/#{RANGE.sample}",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 65),
      personal_details: {
        address: Faker::Address.full_address,
        bio: Faker::Lorem.paragraph(sentence_count: 3, supplemental: false, random_sentences_to_add: 4),
        email_address: Faker::Internet.email,
        sex: Faker::Gender.short_binary_type,
        interests: Faker::Lorem.sentence(word_count: 3),
        languages: ['English', 'Frensh', 'Spanish']
      },
      status: rand(0..2)
    )
  end

  # Faker::Artist.name #=> "Michelangelo"
end
