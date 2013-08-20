require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

require_relative "book"


ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql', 
	:host => 'localhost', 
	:username => 'franklinwahl',
	:password => '',
	:database => 'favorites',
	:encoding => 'utf8'
)


get "/" do
	@books = Book.all
	erb :index
end


get "/new_book" do 
	erb :new_book
end

# This route shows the edit form
get "/edit_book/:book_id" do
	@book = Book.find_by_id(params[:book_id])
	erb :edit_book
end

# This route process the sumitted form
post "/save_book/:book_id" do
	@book = Book.find_by_id(params[:book_id])
	if @book.update_attributes(:name => params[:book_name], :genre => params[:book_genre])
		redirect "/"
	else
		erb :edit_book
	end

end


post "/new_book" do 
	# Porcess form data for a new book
	@book = Book.new(:name => params[:book_name], :genre => params[:book_genre])
	if @book.save
		redirect "/"
	else
		erb :new_book
	end
end


