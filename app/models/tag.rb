class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿をもつ　book_tagsを通して参照できる
  has_many :books, through: :book_tags
  
  validates :name, uniqueness: true, presence: true
  
  
  
  
end
