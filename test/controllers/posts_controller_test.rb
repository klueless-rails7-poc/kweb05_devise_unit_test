require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:customer)
    @post = posts(:one)
  end

  test 'should get index' do
    sign_out users(:customer)
    get posts_url
    assert_response :success
  end

  test 'should get new if signed in' do
    get new_post_url
    assert_response :success
  end

  test 'should get new if signed out' do
    sign_out users(:customer)
    get new_post_url users(:customer)
    assert_response :unauthorized
  end

  test 'should create post if signed in' do
    assert_difference('Post.count') do
      post posts_url, params: { post: { body: @post.body, title: @post.title, user_id: @post.user_id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test 'should create post if signed out' do
    sign_out users(:customer)
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { body: @post.body, title: @post.title, user_id: @post.user_id } }
    end

    assert_response :redirect
  end

  test 'should show post' do
    sign_out users(:customer)
    get post_url(@post)
    assert_response :success
  end

  test 'should get edit if signed in' do
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should get edit if signed out' do
    sign_out users(:customer)
    get edit_post_url(@post)
    assert_response :redirect
  end

  test 'should update post if signed in' do
    patch post_url(@post), params: { post: { body: @post.body, title: @post.title, user_id: @post.user_id } }
    assert_redirected_to post_url(@post)
  end

  test 'should update post if signed out' do
    sign_out users(:customer)
    patch post_url(@post), params: { post: { body: @post.body, title: @post.title, user_id: @post.user_id } }
    assert_response :redirect
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
