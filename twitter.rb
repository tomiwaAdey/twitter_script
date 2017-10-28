require 'watir'
require "google_drive"

@session = GoogleDrive::Session.from_config("google_drive_config.json")

#Config
@config = {
	twitter_username: '',
	twitter_password: '',
	spreadsheet_key: '',
	get_followers_of: '',
	search_term: ''
}

#Spread Sheet Column setting
#COlUMN 1 - TWITTER URL
#COlUMN 2 - FULL NAME
#COLUMN 3 - WEBSITE
#COLUMN 4 - FOLLOWING_COUNT
#COLUMN 5 - FOLLOWER_COUNT

#Define your columns by their number
module Column
  TWITTER_URL = 1
  FULL_NAME = 2
  WEBSITE = 3
  FOLLOWING_COUNT = 4
  FOLLOWER_COUNT = 5
	RELATIONSHIP = 6
end

@ws = @session.spreadsheet_by_key(@config[:spreadsheet_key]).worksheets[0]

#Retry after 5 seconds when error occurs
def with_error_handling
  yield
rescue => e
  sleep(5)
  return e
end


#Log in to Twitter
def login
	browser = Watir::Browser.new :phantomjs
	#browser = Watir::Browser.new :safari
  browser.driver.manage.window.maximize
  browser.goto("https://twitter.com/login")
  sleep 5
  browser.text_field(:xpath => '//*[@id="page-container"]/div/div[1]/form/fieldset/div[1]/input').set @config[:twitter_username]
  browser.text_field(:xpath => '//*[@id="page-container"]/div/div[1]/form/fieldset/div[2]/input').set @config[:twitter_password]
  browser.button(:xpath => '//*[@id="page-container"]/div/div[1]/form/div[2]/button').click
  sleep 2
  return browser
end


#Get all the urls from your google sheets
def initialize_from_gsheet
  browser = Watir::Browser.new :phantomjs
  browser.driver.manage.window.maximize
  (2..@ws.num_rows).each do |row|
    get_twitter_info(row, @ws[row, Column::TWITTER_URL], browser)
    sleep 10
  end
end

#Add the followers of a user to a google sheet
def add_twitter_friend_list_to_gsheet
  browser = login
	sleep 5
  browser.goto(@config[:get_followers_of] + "/followers")
	sleep 5
  loop do
    link_count = browser.links(:class => ["fullname", "ProfileNameTruncated-link"]).size
    browser.divs(:class => "Grid-cell").last.wd.location_once_scrolled_into_view
    sleep 10
    break if browser.links(:class => ["fullname", "ProfileNameTruncated-link"]).size === link_count
  end
	row = 0
  browser.links(:class => ["fullname", "ProfileNameTruncated-link"]).each do |link|
		row += 1
		get_twitter_info(row, link.href)
  end
end

#Gets the first snd last name, website, following_count, and follower_count of the twitter user
def get_twitter_info(row, profile_url)
	browser = Watir::Browser.new :phantomjs
  browser.driver.manage.window.maximize
  browser.goto(profile_url)
	sleep 5
  name = with_error_handling {get_name(browser)}
  website = with_error_handling {get_website(browser)}
  following_count = with_error_handling {get_following(browser)}
  follower_count = with_error_handling {get_followers(browser)}

  add_info_to_gsheet(row, profile_url, name, website, following_count, follower_count)
	sleep 10
end

def get_name(page)
  name_element = page.element(:xpath => '//*[@id="page-container"]/div[2]/div/div/div[1]/div/div/div/div[1]/h1/a')
  return (name_element.present?)? name_element.text : ' '
end

def get_website(page)
  website_element = page.element(:xpath => '//*[@id="page-container"]/div[2]/div/div/div[1]/div/div/div/div[1]/div[2]/span[2]/a')
  return (website_element.present?)? website_element.text : ' '
end

def get_following(page)
  following_element = page.element(:xpath => '//*[@id="page-container"]/div[1]/div/div[2]/div/div/div[2]/div/div/ul/li[2]/a/span[3]')
  return (following_element .present?)? following_element.text : ' '
end

def get_followers(page)
  follower_element = page.element(:xpath => '//*[@id="page-container"]/div[1]/div/div[2]/div/div/div[2]/div/div/ul/li[3]/a/span[3]')
  return (follower_element .present?)? follower_element.text : ' '
end

#adds the user details back to the google sheet
def add_info_to_gsheet(row, profile_url, name, website, following_count, follower_count)
	@ws[row, Column::TWITTER_URL] = profile_url
  @ws[row, Column::FULL_NAME] = first_name
  @ws[row, Column::LAST_NAME] = last_name
  @ws[row, Column::WEBSITE] = website
  @ws[row, Column::FOLLOWING_COUNT] = following_count.gsub('.','')
  @ws[row, Column::FOLLOWER_COUNT] = follower_count.gsub('.','')
  @ws.save
end



#Use to cleanup your list of usernames
def cleanup_scrape_similar_data
  (1..@ws.num_rows).each do |row|
    @ws[row].delete_row if !@ws[row, 1].include?('@')
    details = @ws[row,1].split('@')
    fullname = details[1]
    username = details[-1]
    profile_url = "https://twitter.com/" + username
    @ws[row, 1] = profile_url
    @ws[row, 2] = fullname
    @ws.save
  end
end

#Follows users from a list of users in google spreadsheet
def relationship(action)
  browser = login
  sleep 5
  (1..@ws.num_rows).each do |row|
		if action === "follow"
			next if @ws[row, Column::RELATIONSHIP] === "Followed"
		else
			next if @ws[row, Column::RELATIONSHIP] === "UnFollowed"
		end
    browser.goto(@ws[row, Column::TWITTER_URL])
    sleep 5
	  browser.execute_script("var el = document.getElementsByClassName('follow-button'); el[0].click();")
    @ws[row, Column::RELATIONSHIP] = (action === "follow") ? "Followed" : "UnFollowed"
    @ws.save
    sleep 5
  end
end


#initialize_from_gsheet
#cleanup_scrape_similar_data
#add_twitter_friend_list_to_gsheet
#relationship('follow')
#relationship('unfollow')
