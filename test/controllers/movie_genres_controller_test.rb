require 'test_helper'

class MovieGenresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_genre = movie_genres(:one)
  end

  test 'should get index' do
    get movie_genres_url, as: :json
    assert_response :success
  end

  test 'should create movie_genre' do
    assert_difference('MovieGenre.count') do
      post movie_genres_url, params: { movie_genre: { name: @movie_genre.name } }, as: :json
    end

    assert_response :created
  end

  test 'should show movie_genre' do
    get movie_genre_url(@movie_genre), as: :json
    assert_response :success
  end

  test 'should update movie_genre' do
    patch movie_genre_url(@movie_genre), params: { movie_genre: { name: @movie_genre.name } }, as: :json
    assert_response :success
  end

  test 'should destroy movie_genre' do
    assert_difference('MovieGenre.count', -1) do
      delete movie_genre_url(@movie_genre), as: :json
    end

    assert_response :no_content
  end
end
