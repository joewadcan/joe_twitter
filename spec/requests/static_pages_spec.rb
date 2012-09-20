require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the h1 'Joe Twitter'" do
    	visit '/static_pages/home'
        page.should have_selector("h1", :text=> "Joe Twitter")
    end

    it "should have the right title " do
    	visit '/static_pages/home'
        page.should have_selector("title", :text=> "Joe Twitter | Home")
    end


  end

  describe "Help page" do
    it "should have the h1 'Help'" do
    	visit '/static_pages/help'
        page.should have_selector('h1', :text=> "Help")
    end

    it "should have the right title " do
    	visit '/static_pages/help'
        page.should have_selector('title', :text=> "Joe Twitter | Help")
    end
  end

  describe "About page" do
    it "should have the h1 'About Us'" do
    	visit '/static_pages/about'
        page.should have_selector('h1', :text=> "About Us")
    end

    it "should have the right title " do
    	visit '/static_pages/about'
        page.should have_selector('title', :text=> "Joe Twitter | About")
    end

  end
end
