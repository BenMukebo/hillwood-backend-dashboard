require 'test_helper'

class MovieWrittersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_writter = movie_writters(:one)
  end

  test 'should get index' do
    get movie_writters_url, as: :json
    assert_response :success
  end

  test 'should create movie_writter' do
    assert_difference('MovieWritter.count') do
      post movie_writters_url,
           params: { movie_writter: { avatar_url: @movie_writter.avatar_url,
                                      first_name: @movie_writter.first_name, last_name: @movie_writter.last_name,
                                      personal_details: @movie_writter.personal_details, status: @movie_writter.status } }, as: :json
    end

    assert_response :created
  end

  test 'should show movie_writter' do
    get movie_writter_url(@movie_writter), as: :json
    assert_response :success
  end

  test 'should update movie_writter' do
    patch movie_writter_url(@movie_writter),
          params: { movie_writter: { avatar_url: @movie_writter.avatar_url,
                                     first_name: @movie_writter.first_name, last_name: @movie_writter.last_name,
                                     personal_details: @movie_writter.personal_details, status: @movie_writter.status } }, as: :json
    assert_response :success
  end

  test 'should destroy movie_writter' do
    assert_difference('MovieWritter.count', -1) do
      delete movie_writter_url(@movie_writter), as: :json
    end

    assert_response :no_content
  end
end
