require 'spec_helper'

describe PostsController do


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  let(:character) { Factory(:character) }
  let(:user) { Factory(:user, character: character) }
  let(:post_record) { Factory(:post) }
  let(:valid_attributes) { {character_id: character.id, content: "Lorem ipsum"} }

  before do
    stub_can.and_return(true)
  end

  describe "GET index" do
    it "should render index" do
      get :index
      response.should render_template(:index)
    end

    it "assigns all posts as @posts" do
      post_record
      get :index
      assigns(:posts).should eq([post_record])
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      get :new
      assigns[:post].should be_a_new(Post)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, {:post => valid_attributes}
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, {:post => valid_attributes}, valid_session
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end

      it "redirects to the created post" do
        post :create, {:post => valid_attributes}, valid_session
        response.should redirect_to(posts_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => {}}, valid_session
        assigns(:post).should be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post" do
      post_record
      get :edit, {:id => post_record.to_param}
      assigns(:post).should eq(post_record)
    end
  end

  describe "PUT update" do
    before do
      post_record
    end

    describe "with valid params" do
      it "updates the requested post" do
        # Assuming there are no other posts in the database, this
        # specifies that the Post created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Post.any_instance.should_receive(:update_attributes).with({'content' => 'params'})
        put :update, {:id => post_record.to_param, :post => {'content' => 'params'}}
      end

      it "assigns the requested post as @post" do
        put :update, {:id => post_record.to_param, :post => valid_attributes}
        assigns(:post).should eq(post_record)
      end

      it "redirects to the post" do
        put :update, {:id => post_record.to_param, :post => valid_attributes}
        response.should redirect_to(posts_url)
      end
    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, {:id => post_record.to_param, :post => {}}, valid_session
        assigns(:post).should eq(post_record)
      end

      it "re-renders the 'edit' template" do
        post_record
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, {:id => post_record.to_param, :post => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  pending do
    describe "DELETE destroy" do
      before do
        post_record
      end

      it "destroys the requested post" do
        expect {
          delete :destroy, {:id => post_record.to_param}
        }.to change(Post, :count).by(-1)
      end

      it "redirects to the posts list" do
        delete :destroy, {:id => post_record.to_param}
        response.should redirect_to(posts_url)
      end
    end
  end

end
