class CreateArticleImages < ActiveRecord::Migration[7.0]
  def change
    create_table :article_images do |t|
      t.belongs_to :article, foreign_key: true

      t.timestamps
    end
  end
end
