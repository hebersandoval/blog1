Notes about your code

Strong params:

# strong params, when enabled, rails needs to be told what parameters are allowed to be submitted through the form to th db. the default is to let nothing through.

```
private

def post_params

  # require: it means that the params that get passed in MUST contain a key called "post". if it doesn't, it fails and the user gets an error.

  params.require(:post).permit(:title, :content)

  # permit: it means that the params hash MAY have whatever keys are in it. so in the case of #create case, it may have the :title and :content keys. if it doesn't have one of those keys, its no problem, the hash just wont accept any other keys.

end
```

### Validations with `form_for`
```
<%= form_for(@post) do |f| %>
  <%= render "shared/error_messages", object: f.object %>

  <%= f.label :title %>
  <%= f.text_field :title %>

  <%= f.label :content %>
  <%= f.text_area :content %>

  <%= f.submit %>
<% end %>
```
#### `form_for` automatically performs a route lookup o find the right URL for post. `form_for` takes a block. It passesand instance of FormHelper as a parameter to the block, which is what `f` is above.

##### `form_for` knows that an empty, unsaved model object needs a `new` form and a populated object needs an `edit` form.

### Re-Rendering with errors

#### CRUD methods return `false` when validation fails.

```
def create
  @post = Post.new(post_params)
  if @post.save
    redirect_to post_path(@post)
  else
    render "new"
  end
end
```

### Adding comments to a post_path
```
<!-- app/views/posts/show.html.erb -->
<p>
  <strong>Title:</strong>
  <%= @post.title %>
</p>

<p>
  <strong>Text:</strong>
  <%= @post.content %>
</p>

<h2>Comments</h2>
<% @post.comments.each do |comment| %>
  <%= render @post.comments %>
<% end %>

<h2>Add a comment:</h2>
<%= render "comments/form" %>

<%= link_to 'Edit', edit_post_path(@post) %> |
<%= link_to 'Back', posts_path %>
```

### Using partials

#### This will now render the partial in `app/views/comments/_comment.html.erb` once for each comment that is in the `@post.comments` collection. As the render method iterates over the `@post.comments` collection, it assigns each comment to a local variable named the same as the partial, in this case comment which is then available in the partial for us to show.

```
<!-- app/views/comments/_comment -->
<p>
  <strong>Commenter:</strong>
  <%= comment.commenter %>
</p>

<p>
  <strong>Comment:</strong>
  <%= comment.content %>
</p>
```

#### The second render just defines the partial template we want to render, `comments/form`. Rails is smart enough to spot the forward slash in that string and realize that you want to render the `_form.html.erb` file in the `app/views/comments` directory.

#### The `@article` object is available to any partials rendered in the view because we defined it as an instance variable.
```
<%= form_for([@post, @post.comments.build]) do |f| %>

  <%= f.label :content %><br>
  <%= f.text_area :content %><br>

  <%= f.submit %>
<% end %>
```
