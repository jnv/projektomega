require 'spec_helper'

describe CharactersController do
  # This should return the minimal set of attributes required to create a valid
  # Character. As you add validations to Character, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {number: '1', name: 'Mata Hari'}
  end

  def mock_character(stubs={})
    @mock_character ||= mock_model(Character, stubs).as_null_object
  end


  describe "GET index" do
    it "should render index" do
      get :index
      response.should render_template(:index)
    end

    it "assigns all characters as @characters" do
      #Character.stub(:all) { [mock_character] }
      character = Factory.create(:character)
      get :index
      assigns(:characters).should eq([character])
    end
  end

  describe "GET show" do
    it "assigns the requested character as @character" do
      #Character.stub(:find).with("42") { mock_character }
      character = Factory.create(:character)
      get :show, id: character.id
      assigns(:character).should eq(character)
    end
  end

  describe "GET new" do

    describe "for guest" do
      before { get :new }

      it "should redirect guest to sign_in" do
        response.should redirect_to('/users/sign_in')
        pending "Redirect with flash message"
      end

      it "shouldn't render new template for guest" do
        #response.should_not respond_with(:success)
        #assigns(:character).should_not be_a_new(Character)
        response.should_not render_template(:new)
      end
    end

    describe "for role :user" do
      before :each do
        login_user
        get :new
      end

      it "should redirect to home page" do
        response.should redirect_to(root_url)
        pending "Redirect with flash message"
      end

      it "shouldn't render new template for :user" do
        response.should_not render_template(:new)
      end

    end

    describe "for admin" do
      before do
        login_admin
        get :new
      end

      it "should render new template" do
        response.should render_template(:new)
      end

    end
  end

  describe "GET edit" do

    describe "for authorized user" do
      before do
        @user = login_user
        @character = Factory.create(:character, user: @user)

        #@character.user = @user
      end

      it "allows edit only Character owned by user" do
        get :edit, id: @character.id

        response.should render_template(:edit)
      end

      it "disallows edit for Character not owned by user" do
        newchar = Factory.create(:character)
        get :edit, id: newchar.id

        response.should_not render_template(:edit)
      end

      it "assigns the requested character as @character" do
        get :edit, id: @character.id
        assigns(:character).should eq(@character)
      end
    end

    describe "for unauthorized guest" do
      before do
        @character = Factory.create(:character)
        @user = Factory.create(:user)
        @character.user = @user
      end

      it "disallows edit for any character" do
        get :edit, id: @character.id

        response.should_not render_template(:edit)
      end


    end
  end

  describe "POST create" do

    it "fails for regular user" do
      login_user

      expect {
        post :create, :character => valid_attributes
      }.to_not change(Character, :count)

    end

    before do
      login_admin
    end

    describe "with valid params" do
      it "creates a new Character" do
        expect {
          post :create, :character => valid_attributes
        }.to change(Character, :count).by(1)
      end

      it "assigns a newly created character as @character" do
        Character.stub(:new).with({'these' => 'params'}) { mock_character(save: true) }
        post :create, :character => {'these' => 'params'}
        assigns(:character).should be(mock_character)
      end

      it "redirects to the created character" do
        Character.stub(:new) { mock_character(save: true) }
        post :create, :character => {}
        response.should redirect_to(character_url(mock_character))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved character as @character" do
        # Trigger the behavior that occurs when invalid params are submitted
        Character.stub(:new).with({'these' => 'params'}) { mock_character(save: false) }
        post :create, character: {'these' => 'params'}
        assigns(:character).should be(mock_character)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Character.stub(:new) { mock_character(save: false) }
        post :create, :character => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do


    context "role :user" do
      before do
        @user = login_user
      end
      it "should fail if doesn't own this character" do
        Character.should_receive(:find).with("42") { mock_character }
        mock_character.should_not_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "42", :character => {'these' => 'params'}

      end

      it "should be successful if does own this character" do
        character = Factory.create(:character, user: @user)
        put :update, :id => character.id, :character => {'name' => 'blargh'}
        character.reload
        character.name.should == 'blargh'
      end
    end

    context 'role :admin' do

      before do
        login_admin
      end

      describe "with valid params" do
        it "updates the requested character" do
          Character.should_receive(:find).with("42") { mock_character }
          mock_character.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "42", :character => {'these' => 'params'}
        end

        it "assigns the requested character as @character" do
          Character.stub(:find) { mock_character(:update_attributes => true) }
          put :update, :id => "1"
          assigns(:character).should be(mock_character)
        end

        it "redirects to the character" do
          Character.stub(:find) { mock_character(:update_attributes => true) }
          put :update, :id => "1"
          response.should redirect_to(character_url(mock_character))
        end
      end

      describe "with invalid params" do
        it "assigns the character as @character" do
          Character.stub(:find) { mock_character(:update_attributes => false) }
          put :update, :id => "1"
          assigns(:character).should be(mock_character)
        end

        it "re-renders the 'edit' template" do
          Character.stub(:find) { mock_character(:update_attributes => false) }
          put :update, :id => "1"
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do

    context "role :user" do
      it "doesn't destroy the requested character" do
        login_user
        Character.stub(:find).with("37") { mock_character }
        mock_character.should_not_receive(:destroy)
        delete :destroy, :id => "37"
      end
    end

    context "role :admin" do
      before do
        login_admin
      end

      it "destroys the requested character" do
        Character.should_receive(:find).with("37").at_least(:once) { mock_character }
        mock_character.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the characters list" do
        Character.stub(:find) { mock_character }
        delete :destroy, :id => "1"
        response.should redirect_to(characters_url)
      end
    end

  end

end


