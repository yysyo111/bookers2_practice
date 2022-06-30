class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  validates :rate, presence:true
  
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags
  
  has_many :categories, dependent: :destroy
  
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうか
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags 
    new_tags = sent_tags - current_tags
    
    old_tags.each do |old|
      self.book_tags.delete Tag.find_by(name: old)
    end
    
    new_tags.each do |new|
      new_book_tag = Tag.find_or_create_by(name: new)
      self.tags << new_book_tag 
    end
    
  end
  
  
end
