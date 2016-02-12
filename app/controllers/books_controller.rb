class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    if @book = Book.create(book_params)
      flash[:message] = "Book Created"
      redirect_to book_path(@book)
    else
      flash[:message] = "Uh Oh!"
      render "new"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:message] = "Book Updated"
      redirect_to books_path
    else
      flash[:message] = "Uh Oh!"
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!
    flash[:message] = "Boom! book gone"
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :content)
  end

end
