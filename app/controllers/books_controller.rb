class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
    @book_comment = BookComment.new
    @book_tags = @book.tags #そのクリックした投稿に紐付けられているタグの取得。
  end


  def index
    @books = Book.all
    @book = Book.new
    @tag_list = Tag.all
    @categories = Category.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:name].split(nil)
    if @book.save
      @book.save_tag(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @books = @tag.books.all  #クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :category_id)
  end


  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end

end
