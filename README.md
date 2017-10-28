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
    

##Get lead details from a list of Twitter profile URLS in a Google Sheet
* Open the source code in Atom by opening up the Atom editor on your computer, click on File > Open. Select the bots folder on the Desktop and click the “Open” button.
* Get your Google Sheet key and enter it in @your_config > spreadsheet_key in the twitter.rb file.
* ![How to get your google sheet key](https://lh4.googleusercontent.com/7Q0oulBdGR94PRNN8byIgHXDSj5AqEnntrIf9IV4sNLCLX81VRPiaVAb0YMmUvEamaS9u8vsN_vjp2AJpse6KyLkgH20SZN3GrxGVma-WBeVitepnMC_ecBaGOzIwQP_NyMnGbI9)
* Make sure the list of your Twitter profile urls are in the first column.
* Uncomment line 168 by removing the # in front of initialize_from_gsheet.
* Open up your command line by searching for “cmd.exe” on Windows or “terminal” on Mac. 
* Then navigate to the bots folder, provided you followed the installation guide above and placed the script in the bots folder on your Desktop. If not, navigate to where you put it.
 * If you're on Windows enter: `cd \Desktop\bots`
 * If you're on Mac enter: `cd Desktop/bots`
* Run the script by running: `ruby twitter.rb`
