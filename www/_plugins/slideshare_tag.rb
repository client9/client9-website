module Jekyll
  module SlideShare
    def slideshare(code)
      "<div style='text-align:center;width:100%;'><iframe width='597' height='486' " +
      "style='margin-left:auto;margin-right:auto;border=1px solid #CCC;border-width:1px 1px 0;margin-bottom:5px' " +
      "src='http://www.slideshare.net/slideshow/embed_code/#{code}?rel=0'>&nbsp;</iframe></div>"
    end
  end
end

Liquid::Template.register_filter(Jekyll::SlideShare)

