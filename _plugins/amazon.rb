module Jekyll
  module AmazonAffiliate
    def amazon_product_box(code)
      "<iframe src='http://rcm.amazon.com/e/cm?lt1=_blank&bc1=000000&IS2=1&npa=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=client9-20&o=1&p=8&l=as1&m=amazon&f=ifr&ref=tf_til&asins=#{code}' " +
      "style='width:120px;height:240px;' " +
      "scrolling='no' marginwidth='0' marginheight='0' frameborder='0'>" +
      "&nbsp;</iframe>"
    end
    def amazon_product_link(code)
        "<a href='http://www.amazon.com/gp/product/#{code}/ref=as_li_tf_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=#{code}&linkCode=as2&tag=client9-20'>Cryptography for Internet and Database Applications: Developing Secret and Public Key Techniques with Java</a><img src='http://www.assoc-amazon.com/e/ir?t=client9-20&l=as2&o=1&a=#{code}' width='1' height='1' border='0' alt='' style='border:none !important; margin:0px !important;' />"
    end
  end
end

Liquid::Template.register_filter(Jekyll::AmazonAffiliate)
