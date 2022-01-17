class Book < ApplicationRecord
  # 使用するgemを読み込み
  require 'rakuten_web_service'

  # ARGV[0]で実行時の1つめのパラメータを取得、存在しない場合は'Ruby'を設定
  keyword = ARGV[0] || 'Ruby'

# rakuten_web_serviceの使用法に乗っ取りHTTPリクエストを送ってデータを取得
  items = RakutenWebService::Ichiba::Item.search(keyword: keyword)

  has_many :microposts
  has_many :favorites
  has_many :lovers, through: :favorites, source: :user
  has_many :review1s, dependent: :destroy
  has_many :users
  
end
