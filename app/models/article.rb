class Article < ApplicationRecord
    include ArticleImagesHandler
    has_many :article_images, dependent: :destroy

end
