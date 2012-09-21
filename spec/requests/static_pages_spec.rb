require 'spec_helper'

describe "StaticPages" do
  let(:sitetitle) {"Joe Twitter"}
  describe "Home page" do
    it "should have the h1 'Joe Twitter'" do
    	visit '/static_pages/home'
        page.should have_selector("h1", :text=> "Joe Twitter")
    end

    it "should have the right title " do
    	visit '/static_pages/home'
        page.should have_selector("title", :text=> "#{sitetitle}")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector("title", :text => "| Home")

    end

  end

  describe "Help page" do
    it "should have the h1 'Help'" do
    	visit '/static_pages/help'
        page.should have_selector('h1', :text=> "Help")
    end

    it "should have the right title " do
    	visit '/static_pages/help'
        page.should have_selector('title', :text=> "#{sitetitle} | Help")
    end
  end

  describe "About page" do
    it "should have the h1 'About Us'" do
    	visit '/static_pages/about'
        page.should have_selector('h1', :text=> "About Us")
    end

    it "should have the right title " do
    	visit '/static_pages/about'
        page.should have_selector('title', :text=> "#{sitetitle} | About")
    end

  end

  describe "Contact page" do
    it "should have the h1 'Contact Me'" do
    	visit '/static_pages/contact'
        page.should have_selector('h1', :text=> "Contact Me")
    end

    it "should have the right title " do
    	visit '/static_pages/contact'
        page.should have_selector('title', :text=> "#{sitetitle} | Contact Me")
    end

  end


end
