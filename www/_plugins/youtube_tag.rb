module Jekyll
  module YouTube
    def youtube(code)
        "<iframe width='420' height='315' src='http://www.youtube.com/embed/#{code}' frameborder='0' allowfullscreen></iframe>"
    end
  end
end

Liquid::Template.register_filter(Jekyll::YouTube)
