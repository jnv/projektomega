require 'spec_helper'

describe PostsController do

  let(:valid_attributes) { Factory.attributes_for(:post) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  shared_examples "posts CRUD read index" do
    it "should render index" do
      get :index
      response.should render_template(:index)
    end

    it "assigns all posts as @posts" do
      post_obj
      get :index, {}, valid_session
      assigns(:posts).should eq([post_obj])
    end
  end

  shared_examples "posts CRUD create" do
    describe "GET new" do
      it "assigns a new post as @post" do
        get :new, {}, valid_session
        assigns(:post).should be_a_new(Post)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Post" do
          expect {
            post :create, {:post => valid_attributes}, valid_session
          }.to change(Post, :count).by(1)
        end

        it "assigns a newly created post as @post" do
          post :create, {:post => valid_attributes}, valid_session
          assigns(:post).should be_a(Post)
          assigns(:post).should be_persisted
        end

        it "redirects to the created post" do
          post :create, {:post => valid_attributes}, valid_session
          response.should redirect_to(Post.last)
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
  end

  shared_examples "posts CRUD update" do
    describe "GET edit" do
      it "assigns the requested post as @post" do
        post_obj
        get :edit, {:id => post.to_param}, valid_session
        assigns(:post).should eq(post)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested post" do
          post = Post.create! valid_attributes
          # Assuming there are no other posts in the database, this
          # specifies that the Post created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Post.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => post.to_param, :post => {'these' => 'params'}}, valid_session
        end

        it "assigns the requested post as @post" do
          post_obj
          put :update, {:id => post.to_param, :post => valid_attributes}, valid_session
          assigns(:post).should eq(post)
        end

        it "redirects to the post" do
          post_obj
          put :update, {:id => post.to_param, :post => valid_attributes}, valid_session
          response.should redirect_to(post)
        end
      end

      describe "with invalid params" do
        it "assigns the post as @post" do
          post_obj
          # Trigger the behavior that occurs when invalid params are submitted
          Post.any_instance.stub(:save).and_return(false)
          put :update, {:id => post.to_param, :post => {}}, valid_session
          assigns(:post).should eq(post)
        end

        it "re-renders the 'edit' template" do
          post_obj
          # Trigger the behavior that occurs when invalid params are submitted
          Post.any_instance.stub(:save).and_return(false)
          put :update, {:id => post.to_param, :post => {}}, valid_session
          response.should render_template("edit")
        end
      end
    end
  end

  shared_examples "posts CRUD destroy" do
    describe "DELETE destroy" do
      it "destroys the requested post" do
        expect {
          delete :destroy, {:id => post_obj.to_param}, valid_session
        }.to change(Post, :count).by(-1)
      end

      it "redirects to the posts list" do
        delete :destroy, {:id => post_obj.to_param}, valid_session
        response.should redirect_to(posts_url)
      end
    end
  end


  let(:post_obj) { Factory(:post) }

  context "guest user" do
    it_behaves_like "posts CRUD read index"
    it_behaves_like "authorized controller", {
        :new    => :get,
        :create => :post
      }
  end

end
