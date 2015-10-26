class Scraping < ActiveRecord::Base

@@i = 1

  def self.get_station
    url_ = []
    url = "http://www.navitime.co.jp"
    max_num = 23
    agent = Mechanize.new

    1.upto(max_num) do |num|
      first_url = "http://www.navitime.co.jp/category/list?categoryCode=0802001&addressCode=#{13100+num}&from=view.category.addressList"
      page = agent.get(first_url)
      elements = page.search("ul li.list_frame dl.list_item_frame dt.spot_name a")
      elements.each do |ele|
        p ele.inner_text
        url_ << ele.inner_text
        station = Station.where(:name =>"#{ele.inner_text}", :ward_id => num.to_i).first_or_initialize
        station.save
      end
      if (num.to_i== 1 || 2 || 3 || 4 || 8 || 9 || 11 || 12 || 16 || 18 || 21)
        second_url = "http://www.navitime.co.jp/category/list?categoryCode=0802001&addressCode=#{13100+num}&page=2&from=view.category.page.number"
        page = agent.get(second_url)
        elements = page.search("ul li.list_frame dl.list_item_frame dt.spot_name a")
        elements.each do |ele|
          p ele.inner_text
          url_ << ele.inner_text
          station = Station.where(:name =>"#{ele.inner_text}", :ward_id => num.to_i).first_or_initialize
          station.save
        end
        if (num.to_i == 11)
          third_url = "http://www.navitime.co.jp/category/list?categoryCode=0802001&addressCode=#{13100+num}&page=3&from=view.category.page.number"
          page = agent.get(second_url)
          elements = page.search("ul li.list_frame dl.list_item_frame dt.spot_name a")
          elements.each do |ele|
            p ele.inner_text
            url_ << ele.inner_text
            station = Station.where(:name =>"#{ele.inner_text}", :ward_id => num.to_i).first_or_initialize
            station.save
          end
        end
      end
      p "#{num}--------------------------------"
    end

    p url_

    # elements = page.search("div.area_list ul.address_list li.left a")
    # elements.each do |ele|
    #   url_ << "http://www.navitime.co.jp#{ele.get_attribute('href')}"
    # end

    # url_.each do |purl|
    #   # put_ward(purl)
    #   @@i += 1
    # end
  end

  def self.get_ward
    url = "http://www.metro.tokyo.jp/PROFILE/map_to.htm"
    agent = Mechanize.new
    page = agent.get(url)
    ward_elements = page.search("td.bggreen")
    ward_elements.each do |wele|
      ward = Ward.where(name:wele.inner_text).first_or_initialize
      ward.save
    end
  end

  def self.get_wear
    i = 1
    url = "http://event.rakuten.co.jp/fashion/ladiesfashion/brand/"
    agent = Mechanize.new
    page = agent.get(url)
    elements = page.search("div#searchfilter ul li a span.brandWrap span.brandNm")
    elements.each do |ele|
      b = ele.inner_text
      a = b[0]
      p "#{i}:#{a}:#{b}"
      brand = Brand.where(name: b, alphabet: a).first_or_initialize
      brand.save
      i+=1
    end
  end

=begin
    url = "http://www.metro.tokyo.jp/PROFILE/map_to.htm"
    agent = Mechanize.new
    page = agent.get(url)
    ward_elements = page.search("td.bggreen")
    ward_elements.each do |wele|
      ward = Ward.where(name:wele.inner_text).first_or_initialize
      ward.save
    end
=end

  def self.put_brand
    Brand.where(:name => "").first_or_initialize
  end

  def self.put_ward
    url_ = []
    url = "http://www.metro.tokyo.jp/PROFILE/map_to.htm"
    agent = Mechanize.new
    page = agent.get(url)
    ward_elements = page.search("td.bggreen")
    ward_elements.each do |wele|
      url_ << wele.inner_text
      ward = Ward.where(name:wele.inner_text).first_or_initialize
      ward.save
      if wele.inner_text == "江戸川区"
        break
      end
    end
    p url_
    # w1 = Ward.where(:name => "千代田区").first_or_initialize
    # w1.save
  end

  def self.count_station
    i=53
    station_count_array = []
    1.upto(i) do |num|
      station_count = Ward.find(num).stations.count
      if station_count == 0
        station_count_array << num
      end
    end
    p station_count_array
  end
end