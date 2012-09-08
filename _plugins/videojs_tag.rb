module Jekyll
  module VideoJS
    def videojs(code)
      "\n<video id='my_video_1' controls='1' class='video-js vjs-default-skin'" +
      " preload='none' width='600' height='300' poster=''" +
      " data-setup='{}' >\n" +
      "  <source src='#{code}.mp4' type='video/mp4' />\n" +
      "  <source src='#{code}.webm' type='video/webm' />\n" +
      "</video>\n"
    end
  end
end

Liquid::Template.register_filter(Jekyll::VideoJS)
