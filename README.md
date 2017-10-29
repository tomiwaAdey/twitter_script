# Installing this script
* Install Ruby
  * If you're on Mac, you will already have Ruby pre-installed on your machine.
  * If you're using Windows, download these executable files and follow their instructions:
    * Install Ruby with [Ruby Installer](https://rubyinstaller.org/downloads)
    * Install [DevKit](https://rubyinstaller.org/add-ons/devkit)
* Now that the Ruby setup is done, download [Atom Code Editor](https://atom.io)
* Install Watir web driver: `gem install watir-webdriver`
* Install the Google drive gem: `gem install google_drive`
* Install PhantomJS
  * If you're on windows, download the [PhantomJS executable](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-windows.zip)
  * If you're on Mac:
    * [Download Xcode](https://developer.apple.com/xcode) from Apple Store. Apple’s XCode development software is used to build Mac and iOS apps, but it also includes the tools you need to compile software for use on your Mac
    * Install Homebrew and follow the instructions (You’ll see messages in the Terminal explaining what you need to do to complete the installation process): `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    * Verify your installation by entering `brew -v`
* Download the script
* Create a folder called "bots" on your Desktop
* Unzip the file and place its contents in the bots folder on your Desktop.
* Allow the script to access your Google Drive account by getting your google client_id & client_secret [with this guide](https://www.scrappycabin.com/guides/google-drive-authorisation). Once you get your “client_id” and "client_secret" keys, enter it in the file called “google_drive_config.json”
* Now that's all for installation. Next up is how to use the scipt.


## Get lead details from a list of Twitter profile URLS in a Google Sheet
1. Open the source code in Atom by opening up the Atom editor on your computer, click on File > Open. Select the bots folder on the Desktop and click the “Open” button.
1. Get your Google Sheet key and enter it in @config > spreadsheet_key in the twitter.rb file.
![How to get your google sheet key](https://lh4.googleusercontent.com/7Q0oulBdGR94PRNN8byIgHXDSj5AqEnntrIf9IV4sNLCLX81VRPiaVAb0YMmUvEamaS9u8vsN_vjp2AJpse6KyLkgH20SZN3GrxGVma-WBeVitepnMC_ecBaGOzIwQP_NyMnGbI9)
1. Make sure the list of your Twitter profile urls are in the first column.
1. Uncomment line 190 by removing the # in front of initialize_from_gsheet.
1. Open up your command line by searching for “cmd.exe” on Windows or “terminal” on Mac.
1. Then navigate to the bots folder, provided you followed the installation guide above and placed the script in the bots folder on your Desktop. If not, navigate to where you put it.
 1. If you're on Windows enter: `cd \Desktop\bots`
 1. If you're on Mac enter: `cd Desktop/bots`
1. Run the script by running: `ruby twitter.rb &`

## Get all the details of followers/following of any twitter account
1. Open the source code in Atom by opening up the Atom editor on your computer, click on File > Open. Select the bots folder on the Desktop and click the “Open” button.
1. Get your Google Sheet key as explained in the second step above.
1. Make sure your Google sheet is empty.
1. Fill in all of the @config variables. Your twitter username and password, the Google sheet key, and the url of the account you want to get the followers/following of.
1. Uncomment line 192 by removing the # in front of add_twitter_friend_list_to_gsheet('followers'), if you want to get followers.
1. Uncomment line 193 by removing the # in front of add_twitter_friend_list_to_gsheet('following'), if you want to get following.
1. Open up your command line by searching for “cmd.exe” on Windows or “terminal” on Mac.
1. Then navigate to the bots folder, provided you followed the installation guide above and placed the script in the bots folder on your Desktop. If not, navigate to where you put it.
 1. If you're on Windows enter: `cd \Desktop\bots`
 1. If you're on Mac enter: `cd Desktop/bots`
1. Run the script by running: `ruby twitter.rb &`

## Cleanup your list of usernames from the Scrape Similar extension
1. Enter your Google sheet key in the @config > spreadsheet_key.
1. Uncomment line 191 by removing the # in front of cleanup_scrape_similar_data.
1. Open up your command line by searching for “cmd.exe” on Windows or “terminal” on Mac.
1. Then navigate to the bots folder, provided you followed the installation guide above and placed the script in the bots folder on your Desktop. If not, navigate to where you put it.
 1. If you're on Windows enter: `cd \Desktop\bots`
 1. If you're on Mac enter: `cd Desktop/bots`
1. Run the script by running: `ruby twitter.rb &`

## Mass follow/unfollow a list of twitter users on Google sheet
1. Open the source code in Atom by opening up the Atom editor on your computer, click on File > Open. Select the bots folder on the Desktop and click the “Open” button.
1. Get your Google Sheet key as explained in the second step above.
1. Fill in all of the @config variables. Your twitter username and password, and the Google sheet key.
1. Uncomment line 194 by removing the # in front of relationship('follow'), if you want to mass follow.
1. Uncomment line 195 by removing the # in front of relationship('unfollow'), if you want to mass unfollow.
1. Open up your command line by searching for “cmd.exe” on Windows or “terminal” on Mac.
1. Then navigate to the bots folder, provided you followed the installation guide above and placed the script in the bots folder on your Desktop. If not, navigate to where you put it.
 1. If you're on Windows enter: `cd \Desktop\bots`
 1. If you're on Mac enter: `cd Desktop/bots`
1. Run the script by running: `ruby twitter.rb &`
