class BooksController < ApplicationController
  def index
    @books = Book.all
    @book_new = Book.new
  end
  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new.id), notice: "You have creatad book successfully."
    else
      @books = Book.all
      render :index
    end
  end
  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = BookComment.all
  end
  def edit
    @book = Book.find(params[:id]) 
      if @book.user_id == current_user.id
        render :edit
      else
        redirect_to books_path
      end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private
    def book_params
      params.require(:book).permit(:title, :body, :user_id)
    end

  
end
