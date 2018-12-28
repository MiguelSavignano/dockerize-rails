class Post < ApplicationRecord
  after_commit do
    PostCountWordJob.perform_later(self.id)
  end
end
