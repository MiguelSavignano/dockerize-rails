class PostCountWordJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    count_words = post.body.present? ? post.body.split.size : 0
    post.update_column(:count_words, count_words)
  end
end
