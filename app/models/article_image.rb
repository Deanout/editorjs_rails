class ArticleImage < ApplicationRecord
  has_one_attached :image
  belongs_to :article, optional: true
end
