class Api::V1::PostsController < ApplicationController
  def index
    posts_count = Post.count
    per_page = (resource_params[:per_page] || posts_count).to_i
    page = (resource_params[:page] || 1).to_i - 1
    posts = []

    Post.includes(:author).order(:published_at).limit(per_page).offset(per_page*page).each do |p|
      posts.push(trimmer(p))
    end

    response.headers['Pages-Count'] = (posts_count/per_page.to_f).ceil
    response.headers['Posts-Count'] = posts_count
    render json: posts.to_json
  end

  def create
    resource = @current_user.posts.create(resource_params)

    if resource.valid?
      render json: trimmer(resource).to_json, status: :created
    else
      render json: resource.errors.to_json, status: :unprocessable_entity
    end
  end

  def show
    render json: trimmer(Post.find(params[:id])).to_json
  end

  protected

  def trimmer(resource)
    outhash = resource.as_json
    outhash["published_at"] = resource["published_at"].strftime("%Y-%m-%d %H:%M")
    outhash["author"] = resource.author.nickname
    outhash.delete("author_id")
    outhash
  end

  def resource_params
    params.permit(:title, :body, :published_at, :page, :per_page)
  end
end
