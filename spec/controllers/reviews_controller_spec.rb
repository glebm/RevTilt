require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ReviewsController do
  render_views
  
  # This should return the minimal set of attributes required to create a valid
  # Review. As you add validations to Review, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "rating" => "1", "content" => "blah", "condition_id" => "1" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ReviewsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all reviews as @reviews" do
      review = FactoryGirl.create(:review)
      get :index, {}
      assigns(:reviews).should eq([review])
    end
  end

  describe "GET show" do
    it "assigns the requested review as @review" do
      review = FactoryGirl.create(:review)
      get :show, {:id => review.to_param}
      assigns(:review).should eq(review)
    end
  end

  describe "CRUD actions" do
    before(:each) do
      @user = FactoryGirl.create(:user, :admin => true)
      sign_in @user
    end
    
    describe "GET new" do
      it "assigns a new review as @review" do
        get :new, {}
        assigns(:review).should be_a_new(Review)
        assigns(:review).organization.should be_nil
        assigns(:review).user.should eq(@user)
      end
      
      it "should connect an organization to the new review" do
        organization = FactoryGirl.create(:organization)
        get :new, { :o_id => organization.to_param }
        assigns(:review).organization.should eq(organization)
      end
    end

    describe "GET edit" do
      it "assigns the requested review as @review" do
        review = FactoryGirl.create(:review)
        get :edit, {:id => review.to_param}
        assigns(:review).should eq(review)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        before(:each) do
          @organization = FactoryGirl.create(:organization)
        end
        
        it "creates a new Review" do
          expect {
            post :create, {:review => valid_attributes.merge({"organization_id" => @organization.to_param })}
          }.to change(Review, :count).by(1)
        end

        it "assigns a newly created review as @review" do
          post :create, {:review => valid_attributes.merge({"organization_id" => @organization.to_param })}
          assigns(:review).should be_a(Review)
          assigns(:review).should be_persisted
        end
        
        it "assigns the user_id to the signed in user even if another user_id is provided" do
          post :create, {:review => valid_attributes.merge({"user_id" => @user.id + 1 })}
          assigns(:review).user_id.should eq(@user.id)
        end

        it "redirects to the created review" do
          post :create, {:review => valid_attributes.merge({"organization_id" => @organization.to_param })}
          response.should redirect_to(Review.last.organization)
        end
        
        it "redirects to the root_path" do
          post :create, {:review => valid_attributes.merge({"organization_id" => -1 })}
          response.should redirect_to(root_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved review as @review" do
          # Trigger the behavior that occurs when invalid params are submitted
          Review.any_instance.stub(:save).and_return(false)
          post :create, {:review => { "rating" => "invalid value" }}
          assigns(:review).should be_a_new(Review)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Review.any_instance.stub(:save).and_return(false)
          post :create, {:review => { "rating" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested review" do
          review = FactoryGirl.create(:review)
          # Assuming there are no other reviews in the database, this
          # specifies that the Review created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Review.any_instance.should_receive(:update_attributes).with({ "rating" => "1" })
          put :update, {:id => review.to_param, :review => { "rating" => "1" }}
        end

        it "assigns the requested review as @review" do
          review = FactoryGirl.create(:review)
          put :update, {:id => review.to_param, :review => valid_attributes}
          assigns(:review).should eq(review)
        end

        it "redirects to the review" do
          review = FactoryGirl.create(:review)
          put :update, {:id => review.to_param, :review => valid_attributes}
          response.should redirect_to(review)
        end
        
        it "should redirect to the organization" do
          organization = FactoryGirl.create(:organization)
          review = FactoryGirl.create(:review, :organization => organization)
          put :update, {:id => review.to_param, :review => valid_attributes}
          response.should redirect_to(organization)
        end
      end

      describe "with invalid params" do
        it "assigns the review as @review" do
          review = FactoryGirl.create(:review)
          # Trigger the behavior that occurs when invalid params are submitted
          Review.any_instance.stub(:save).and_return(false)
          put :update, {:id => review.to_param, :review => { "rating" => "invalid value" }}
          assigns(:review).should eq(review)
        end

        it "re-renders the 'edit' template" do
          review = FactoryGirl.create(:review)
          # Trigger the behavior that occurs when invalid params are submitted
          Review.any_instance.stub(:save).and_return(false)
          put :update, {:id => review.to_param, :review => { "rating" => "invalid value" }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested review" do
        review = FactoryGirl.create(:review)
        expect {
          delete :destroy, {:id => review.to_param}
        }.to change(Review, :count).by(-1)
      end

      it "redirects to the organization" do
        organization = FactoryGirl.create(:organization)
        review = FactoryGirl.create(:review, :organization => organization)
        delete :destroy, {:id => review.to_param}
        response.should redirect_to(organization)
      end
      
      it "redirects to the root_path" do
        review = FactoryGirl.create(:review)
        delete :destroy, {:id => review.to_param}
        response.should redirect_to(root_path)
      end
    end
  end

end
