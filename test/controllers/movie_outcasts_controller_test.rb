require 'test_helper'

class MovieOutcastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_outcast = movie_outcasts(:one)
  end

  test 'should get index' do
    get movie_outcasts_url, as: :json
    assert_response :success
  end

  test 'should create movie_outcast' do
    assert_difference('MovieOutcast.count') do
      post movie_outcasts_url,
           params: { movie_outcast: {
             avatar_url: @movie_outcast.avatar_url,
             first_name: @movie_outcast.first_name, last_name: @movie_outcast.last_name,
             personal_details: @movie_outcast.personal_details, status: @movie_outcast.status
           } }, as: :json
    end

    assert_response :created
  end

  test 'should show movie_outcast' do
    get movie_outcast_url(@movie_outcast), as: :json
    assert_response :success
  end

  test 'should update movie_outcast' do
    patch movie_outcast_url(@movie_outcast),
          params: { movie_outcast: { avatar_url: @movie_outcast.avatar_url,
                                     first_name: @movie_outcast.first_name, last_name: @movie_outcast.last_name,
                                     personal_details: @movie_outcast.personal_details, status: @movie_outcast.status } }, as: :json
    assert_response :success
  end

  test 'should destroy movie_outcast' do
    assert_difference('MovieOutcast.count', -1) do
      delete movie_outcast_url(@movie_outcast), as: :json
    end

    assert_response :no_content
  end
end
