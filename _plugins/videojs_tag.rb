module Jekyll
  module VideoJS
    def videojs(code)
      "\n<video id='my_video_1' controls='1' class='video-js vjs-default-skin'" +
      " preload='auto' width='640' height='264' poster=''" +
      " data-setup='{}' >\n" +
      "  <source src='#{code}' type='video/mp4' />\n" +
      "</video>\n"
    end
  end
end

Liquid::Template.register_filter(Jekyll::VideoJS)
