class PostView < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :views_count

end
