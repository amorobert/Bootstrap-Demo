   get "/posts" do
     @posts = Post.all
     erb :"/posts/index"
   end

   get "/posts/new" do
     erb :"/posts/new"
   end

   post "/posts" do
     @post = Post.new(params[:post])
     @post.author_id = current_user_id
     if @post.save
       if request.xhr?
         @post
       else
         redirect "/posts"
       end
     else
       @errors = @post.errors.full_messages
       erb :"/posts/new"
     end
   end

   get "/posts/:id" do
     @post = Post.find(params[:id])
     erb "/posts/show"
   end

   get "/posts/:id/edit" do
     @post = Post.find(params[:id])
     erb :"/posts/edit"
   end

   put "/posts/:id" do
     @post = Post.find(params[:id])
     if @post.update(params[:post])
        redirect :"/posts/params[:id]"
     else
     @errors = @post.errors.full_messages
        erb :"posts/edit"
      end
   end

   delete "/posts/:id" do
     @post = Post.find(params[:id])
     @post.destroy
     redirect "/posts/index"
   end
