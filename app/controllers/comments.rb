   get "/comments" do
     @comments = Comment.all
     erb :"/comments/index"
   end

   get "/comments/new" do
     erb :"/comments/new"
   end

   post "/comments" do
     @comment = Comment.new(params[:comment])
     if @comment.save
       if request.xhr?
         @comment
       else
         redirect "/comments"
       end
     else
       @errors = @comment.errors.full_messages
       erb :"/comments/new"
     end
   end

   get "/comments/:id" do
     @comment = Comment.find(params[:id])
     erb "/comments/show"
   end

   get "/comments/:id/edit" do
     @comment = Comment.find(params[:id])
     erb :"/comments/edit"
   end

   put "/comments/:id" do
     @comment = Comment.find(params[:id])
     if @comment.update(params[:comment])
        redirect :"/comments/params[:id]"
     else
     @errors = @comment.errors.full_messages
        erb :"comments/edit"
      end
   end

   delete "/comments/:id" do
     @comment = Comment.find(params[:id])
     @comment.destroy
     redirect "/comments/index"
   end
