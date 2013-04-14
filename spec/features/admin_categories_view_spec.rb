require 'spec_helper'

describe 'the admin categories view', type: :feature do
  let!(:user){ User.create(uber: true, password: "password", password_confirmation: "password", full_name: "Logan", email: "logan@gmail.com", display_name: "Logan") }

  before(:each) do
    visit login_path
    fill_in 'sessions_email', with: 'logan@gmail.com'
    fill_in 'sessions_password', with: 'password'
    click_button 'Login'
    click_link 'pbj'
    click_link '/pbj/admin/dashboard'
    visit store_admin_categories_path
  end

  it 'should have a title' do
    expect(page).to have_selector('h1', text: 'Categories')
  end

  it 'should have a create category button' do
     expect(page).to have_button('Create Category')
  end

  context 'when a category exists' do
    before(:each) do
      click_button "Create Category"
      fill_in 'Title', with: 'mah things'
      click_button "Submit"
    end

    it 'creates a new category with valid input' do
      expect(current_path).to eq store_admin_categories_path
    end

    it 'rejects invalid category input' do
      click_button "Create Category"
      fill_in 'Title', with: 'mah things'
      click_button "Submit"
      expect(page).to have_content "has already been taken"
    end

    it 'edits a category with valid input' do
      click_link "Edit"
      fill_in "Title", with: 'gooey'
      click_button "Submit"
      expect(current_path).to eq store_admin_categories_path
    end
  end
end
