class Restaurant < ApplicationRecord
    mount_uploader :image_path,ImageUploader
    
    validates        :res_name,
                     presence: true
    belongs_to       :state
    belongs_to       :district
    belongs_to       :road
    
    has_many         :menus
    has_many         :scrabs
    has_many         :users, through: :scrabs
    has_many         :reviews
    has_and_belongs_to_many :tags
    has_many         :postings
    
    # after_commit :scan_hashtag_from_body, on: :create
    # after_commit :update_hashtag_from_body, on: :update
    
    paginates_per 8
    
    def search_restaurant(review)
        @tmp  = Restaurant.where("id LIKE ?","#{review.restaurant_id}")[0]
        @tmp.res_name
    end
 
    def self.search_restaurant_ad(condition)
        unless condition.strip.empty?
            Restaurant.where("detail_addr LIKE ?","%#{condition}%")
        end
    end

    # #hashtag
    # def update_hashtag_from_body
    # 	restaurant = Restaurant.find_by(id: self.id)
    #     hashtags = self.contents.split('#')
    #     transaction do
    #         hashtags[1..-1].map do |hashtag|
    #                 next if self.tags.where(name: hashtag).first
    #                 tag= Tag.find_or_create_by(name: hashtag.downcase.strip)
                    
    #                 RestaurantsTag.create(restaurant_id: self.id, tag_id: tag.id)
    #         end
    #     end
    #     #uniq : if user two same hashtags,then only one hashtag register
    #     # hashtags.uniq.map do |hashtag|
    #     #     #find : find specific tag
    #     #     #
    #     #     tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
    #     #     #<< : push the end of the array
    #     #     restaurant.tags << tag
    #     # end
    # end
    
    # def scan_hashtag_from_body
    #     restaurant = Restaurant.find_by(id: self.id)
    #     hashtags = self.contents.split('#')
    #     transaction do
    #         hashtags[1..-1].map do |hashtag|
    #             tag = Tag.find_or_create_by(name: hashtag.downcase.strip)
    #             puts "-----------here-----------"
    #                 p tag
    #              RestaurantsTag.create(restaurant_id: self.id, tag_id: tag.id)
    #         end
    #     end
    # end
    
    def blog_desc(temp, id)
        agent = Mechanize.new
        r = Restaurant.find(id)
        [1,2,3,4,5].each do |index|
            
            page = agent.get"https://search.naver.com/search.naver?where=post&sm=tab_jum&query=#{temp}+#{r.res_name}"
            list = page.search("li#sp_blog_#{index}.sh_blog_top")
            date =list.at("dd.txt_inline").inner_text
            desc = list.at("dd.sh_blog_passage").inner_text
            b_user = list.at("a.txt84").inner_text
            
            #  _sp_each_url _sp_each_title
            url = list.at("a.sh_blog_title").attributes["href"].text
            img = list.at("img.sh_blog_thumbnail").attributes["src"].text
            title = list.at("a.sh_blog_title").attributes["title"].text
            
            @post = Posting.new
            @post.date = date
            @post.desc = desc
            @post.b_user = b_user
            @post.url = url
            @post.b_img = img
            @post.title = title
            @post.restaurant_id =id
            @post.save
        end
    end
end
