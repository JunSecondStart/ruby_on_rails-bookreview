 # rakuten_web_service内のclassで使えるようにアプリケーションIDを設定 <注意>アプリケーションIDをつけたままgitにあげてはいけない（使われまくるから）
  RakutenWebService.configure do |c|
    c.application_id = '1020138923467456239'
  end