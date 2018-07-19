### Model

`review.rb`

### Controller

`review_controller.rb`

```ruby
 # GET /reviews
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    
  end

  # GET /posts/new
  # form_for 태그에서는 꼭 new action 에서 꼭 Post.new (빈 깡통)을 해줘야함.
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    #@post.daum_id = session[:current_cafe]
      if @post.save
         
         redirect_to @post,flash:{success: 'Post was successfully created.'} 
      else
         render :new
      end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
 
      if @post.update(post_params)
        redirect_to @post, flash:{success: 'Post was successfully updated.'} 
      else
        render :edit 
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, flash:{success: 'Post was successfully destroyed.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :taste_eval,:price_eval,:service_eval,:contents, :restaurant_id,:image_path)
 
    end
```



### View

`_form.html.erb`

```erby
<%= form_for(review) do |f| %>

  <%= f.hidden_field :restaurant_id, value: params[:restaurant_id] %>
  <div class="field">
    <%= f.label :title %>
    <%= f.text_field :title, class: 'form-control'%>
  </div>
  
  <div class="field">
    <%= f.label :맛평가 %>
    <%= f.number_field :taste_eval, class: 'form-control'%>
  </div>
  
  <div class="field">
    <%= f.label :가격평가 %>
    <%= f.number_field :price_eval, class: 'form-control'%>
  </div>
  
  <div class="field">
    <%= f.label :서비스평가 %>
    <%= f.number_field :service_eval, class: 'form-control'%>
  </div>

  <div class="form-group">
    <%= f.label :contents %>
    <%= f.text_area :contents, 'data-provider': :summernote %>
  </div>


  <div class="field">
    <%= f.label :image_path %>
    <%= f.file_field :image_path, class: 'form-control'%>
  </div>
   <br><br> 
  <div class="actions text-right">
    <%= f.submit '작성하기',class: 'btn btn-info'%>
    <%= link_to '뒤로가기', reviews_path,class: 'btn btn-warning text-white' %>
  </div>
<% end %>
```

* summer note

* star rating : 마우스를 올리면 star-checked 다시 마우스를 올리면 star.
* 버튼(요소)에 마우스를 올리면(이벤트, 이벤트 리스너)
* 해당 버튼(요소)의 class가 "fa fa-star checked"로 변함(이벤트 핸들러)

```js
var btn = document.getElementsByClassName("container1")[0];
btn.addEventListener("mouseover",function(){
	btn.setAttribute("class","fa fa-star checked")
})
```



if checked == true 면 다시 setAttribute("class","fa fa-star")



name = review[taste_eval]  id =review_taste_eval 



------

* 리뷰를 쓰면 해당 식당 상세보기 (show) 에 리스트 형식으로 리뷰가 떠야한다.
* 먼저 리뷰와 레스토랑을 연결

`restaurants/show.html.erb`

```erb
<ul class="list-group">
  <% @restaurant.reviews.each do |review| %>
  <li class="list-group-item d-flex justify-content-between align-items-center">
     <%= link_to "#{post.title}",post_path(post) %>
     <span class="badge badge-primary badge-pill"><%=post.comments.count%></span>
  </li>
  <% end %>
</ul>
```



```ruby
     맛평가 : 
          <% (1..review.taste_eval).each do%>
              <span class="fa fa-star checked" style="width:11px; margin-top:-5px; font-size:9px; color:#2483ff;"></span>
          <%end%>
          서비스평가 :
          <% (1..review.service_eval).each do%>
              <span  class="fa fa-star checked" style="width:11px; margin-top:-5px; font-size:9px; color:#2483ff;"></span>
          <%end%>
          가격평가 : 
           <% (1..review.price_eval).each do%>
              <span  class="fa fa-star checked" style="padding-left:10px; width:11px; margin-top:-5px; font-size:9px; color:#2483ff;"></span>
          <%end%>
      <br><%=review.contents%>
```

```js
$(document).ready(function(){
  
  var $like = $('.like'),
      $count = $('.count'),
      $liked = false;
  
  function getRandom(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

  var $randNum = getRandom(1, 100);
  $count.text($randNum);
  
  $like.on('click', function(){
    console.log($liked);
    if(!$liked) {
        $(this).addClass('liked');
        $count.text($randNum + 1);
        $liked = true;
    } else {
        $(this).removeClass('liked');
        $count.text($randNum);
        $liked = false;
    }
    
  });
});
```

* 질문 1: 리뷰 작성후 원래 해당 restaurant/:restaurant_id로 이동하도록
* 질문 2: 각각의 리뷰에 좋아요 버튼을 적용하고 싶은데, 여러개의 리뷰중 클릭에 해당하는 review의 id를 어떻게 가져올 것인지.
* 