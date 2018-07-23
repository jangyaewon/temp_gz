require 'csv'
require 'mechanize'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'woman.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
 
  r = Restaurant.new
  r = Restaurant.where(res_name: row['사용장소'], detail_addr: row['상세주소'])[0]
  d = District.where(id: r.district_id)
  
  unless r.nil?
   [1,2,3,4,5].each do |index|
            
            p = Posting.new
            p.restaurant_id = r.id
            
            page = agent.get"https://search.naver.com/search.naver?where=post&sm=tab_jum&query=#{d.district_name}+#{r.res_name}"
            list = page.search("li#sp_blog_#{index}.sh_blog_top")
            date =list.at("dd.txt_inline").inner_text
            desc = list.at("dd.sh_blog_passage").inner_text
            b_user = list.at("a.txt84").inner_text
            
            #  _sp_each_url _sp_each_title
            url = list.at("a.sh_blog_title").attributes["href"].text
            img = list.at("img.sh_blog_thumbnail").attributes["src"].text
            title = list.at("a.sh_blog_title").attributes["title"].text

            p.date = date
            p.desc = desc
            p.b_user = b_user
            p.url = url
            p.b_img = img
            p.title = title
            
            p.save
            p p.id
      end
  end
  
end