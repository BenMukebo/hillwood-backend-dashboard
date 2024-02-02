require 'test_helper'

class OutcastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @outcast = outcasts(:one)
  end

  test 'should get index' do
    get outcasts_url, as: :json
    assert_response :success
  end

  test 'should create outcast' do
    assert_difference('Outcast.count') do
      post outcasts_url,
           params: { outcast: {
             avatar_url: @outcast.avatar_url, date_of_birth: @outcast.date_of_birth,
             first_name: @outcast.first_name, last_name: @outcast.last_name,
             personal_details: @outcast.personal_details, status: @outcast.status
           } }, as: :json
    end

    assert_response :created
  end

  test 'should show outcast' do
    get outcast_url(@outcast), as: :json
    assert_response :success
  end

  test 'should update outcast' do
    patch outcast_url(@outcast),
          params: { outcast: {
            avatar_url: @outcast.avatar_url, date_of_birth: @outcast.date_of_birth,
            first_name: @outcast.first_name, last_name: @outcast.last_name,
            personal_details: @outcast.personal_details, status: @outcast.status
          } }, as: :json
    assert_response :success
  end

  test 'should destroy outcast' do
    assert_difference('Outcast.count', -1) do
      delete outcast_url(@outcast), as: :json
    end

    assert_response :no_content
  end
end
