module PostsHelper
  def render_post_content(post)
    simple_format(truncate(post.content), legnth:50)
  end
end
