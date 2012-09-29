class PostsController < AuthorizedController
  inherit_resources

  # POST /posts
  # POST /posts.json
  def create
    @post.character = current_user.character
    authorize! :create, @post
    create! { posts_url }
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    update! { posts_url }
  end

end
