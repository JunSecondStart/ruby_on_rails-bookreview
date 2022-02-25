class BooksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @pagy, $review1s = pagy(Review1.order(id: :desc), items: 15)
  end
    
  def new
    $title = params[:current_book_title]
    $image_url = params[:current_book_image_url]
    $author = params[:current_book_author]
    $review1s = Review1.where(title: $title) 
    render 'review1s/create'
  end
    
  def search
    #ここで空の配列を作ります
  @books = []
  @book = []
  @title = params[:title]
  i = 0
  $i = []
  $k = 0
  $curent_user_review1s=Review1.where(user_id: current_user.id)
  if @title.present?
      #この部分でresultsに楽天APIから取得したデータ（jsonデータ）を格納します。
      #今回は書籍のタイトルを検索して、一致するデータを格納するように設定しています。
    results = RakutenWebService::Books::Book.search({
      title: @title,
    })
    #この部分で「@books」にAPIからの取得したJSONデータを格納していきます。
    #read(result)については、privateメソッドとして、設定しております。
    results.first(15).each do |result|
      book = Book.new(read(result))
      @books << book
    end
  end
    #「@books」内の各データをそれぞれ保存していきます。
    #すでに保存済の本は除外するためにunlessの構文を記載しています。
  @books.each do |book|
    unless Book.all.include?(book)
      book.save
      i += 1
      @book[i]=book
    end
  end
end

  private
  #「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッドを設定していきます。
  def read(result)
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    {
      title: title,
      author: author,
      url: url,
      image_url: image_url,
      isbn: isbn
    }
  end
end