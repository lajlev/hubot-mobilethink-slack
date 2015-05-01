# Description:
#   A simple json request to get todays lunch menu from frokost.dk through kimono.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot lunch
#
# Notes:
#   None
#
# Author:
#   Michael Lajlev

parser = require 'parse-rss'

# provider = "MuMs!"

# positiveWords = [
#   "an appealing",
#   "a beautiful",
#   "a creamy",
#   "an exceptional",
#   "a fab",
#   "an incredible",
#   "a mouthwatering",
#   "an outstanding",
#   "a slick",
#   "a terrific",
#   "a timeless",
#   "a spectacular",
#   "an absorbing",
#   "a brilliant",
#   "a delicious",
#   "a juicy"
# ]


# intro = [
#   "Today #{provider} is serving us",
#   "It's gonna be wild. Today #{provider} is serving us",
#   "Jackpot. #{provider} is presenting us",
#   "#{provider} has created",
#   "Today #{provider} is serving us",
#   "Today #{provider} is serving us",
# ]

url    = "http://e.frokost.dk/Menuplan/RssMenu.aspx?l=6OKBMXsAjS"

module.exports = (robot) ->
  robot.respond /lunch|todays lunch|lunch today|lunch menu/i, (msg) ->
    parser url, (err,rss)->
      msg.send err if err
      msg.send rss[0].description
                .replace(/<\/?b>/g, "")
                .replace(/<br\/>/g, "\n")
                .replace(/&#230;/g, "æ")
                .replace(/&#198;/g, "Æ")
                .replace(/&#248;/g, "ø")
                .replace(/&#216;/g, "Ø")
                .replace(/&#229;/g, "å")
                .replace(/&#197;/g, "Å")
                .replace(/&amp;/g, "&")
                .trim()

    # msg.http("https://www.kimonolabs.com/api/9adlhc7g?apikey=c8f9ab2a3136ece150fbb950c58ab214")
    #   .get() (err, res, body) ->
    #     try
    #       randomIntroString = Math.floor(Math.random() * intro.length)
    #       randomPositiveWordString = Math.floor(Math.random() * positiveWords.length)
    #       json = JSON.parse(body)
    #       msg.send "#{intro[randomIntroString]} #{positiveWords[randomPositiveWordString]} #{json.data.frokost[0].wed}\n"
    #     catch error
    #       msg.send "Lunch menu couldn't be found"