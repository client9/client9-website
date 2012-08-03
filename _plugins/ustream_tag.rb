module Jekyll
  module UStream
    def ustream(code)
      "<div style='text-align:center;width:100%;'>" +
      "<iframe width='480' height='296' src='http://www.ustream.tv/embed/recorded/#{code}' scrolling='no' frameborder='0' style='border: 0px none transparent;'></iframe><br /><a href='http://www.ustream.tv/' style='padding: 2px 0px 4px; width: 400px; background: #ffffff; display: block; color: #000000; font-weight: normal; font-size: 10px; text-decoration: underline; text-align: center;' target='_blank'>Video streaming by Ustream</a>" +
      "</div>"
    end
  end
end

Liquid::Template.register_filter(Jekyll::UStream)
