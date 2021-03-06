require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

   describe "signin page" do
  	before { visit signin_path }

  	it { should have_selector('h1',    text: 'Sign In') }
    it { should have_selector('title', text: 'Sign In') }

  	describe "with invalid info" do
  		before { click_button "Sign In" }

  		 it { should have_selector('title', text: 'Sign In') }
      	 it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      	 describe "after visiting another page" do
        	before { click_link "Home" }
        	it { should_not have_selector('div.alert.alert-error') }
      	 end
 	  end

 	describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
        
      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Users', href: users_path ) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }


      describe "after saving the user" do
        it { should have_link('Sign out') }
      end

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
  end

  describe "authorization" do

    describe "for non-signed in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when trying to access a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
        end

        describe "after signing in" do
          it "should render the right protected page" do
            page.should have_selector('title', text: "Edit user")
          end

          describe "after signing in again, after leaving" do
            before do
              click_link "Sign out"
              click_link "Sign in"
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "Sign In"
            end

            it "should render the default page of profile" do
              page.should have_selector('title', text: user.name)
            end
          end
        end
     end

      describe "in the users controller" do
        
        describe "visiting the edit page"  do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
          it { should have_selector('div.alert.alert-notice') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign In') }
        end

        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end

        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end


      end #users controllers
    end #nonsigned in users

    describe "Microposts controlla" do 
      describe "submitting to the create action" do
        before { post microposts_path }
        specify { response.should redirect_to(signin_path)}

      end

      describe "submitting to the destroy action" do
        before { delete micropost_path(FactoryGirl.create(:micropost)) }
        specify { response.should redirect_to(signin_path)}

      end
    end

    describe "for relationships controller" do 
      describe "submitting to the create action" do
        before { post relationships_path }
        specify { response.should redirect_to(signin_path)}

      end

      describe "submitting to the destroy action" do
        before { delete relationship_path(1) }
        specify { response.should redirect_to(signin_path)}

      end

    end

    describe "for wrong user " do 
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@user.com") }
      before { sign_in user }

      describe "visiting users#edit" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: 'Edit user') }
      end

      describe "sending a put request to users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end

    end

    describe "as non admins" do 
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitt delete request to Users#destroy" do
        before { delete user_path(user) }

        specify { response.should redirect_to(root_path)}
      end
    end
  end
  end
end
