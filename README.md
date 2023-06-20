# README


# rails起動コマンド
```
rails s
```

# コントローラー作成
例:booklistと呼ばれるコントローラーを作成
```
rails generate controller booklist
```
```app\controllers\booklist_controller.rb```にコントローラーが作成される

# ルーティング設定
```config\routes.rb```で指定
```
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
```
```get:/hello```と```get:/bye```としたい場合は以下のようにする
```
Rails.application.routes.draw do
  
  get 'hello' => 'booklist#hello'
  get 'bye' => 'booklist#bye'

end
```
このままではまだ動かない

# ビューの作成
```app\views\booklist\```に```(アクション名).html.erb```を作成  
上記の場合```hello.html.erb```と```bye.html.erb```となる
(** UTF-8(BOM無) で保存**)

## ビューでの変数使用
コントローラーから```msg```を送る場合
(**日本語を使う場合、#coding: utf-8がないとrails側でエラーが起きる**)
```
# coding: utf-8

class BooklistController < ApplicationController

  def hello
    @msg = 'こんにちは。お久しぶりです。';
  end

end
```

```
<h1>Hello</h1>
<p>
<%= @msg %>
</p>
```

# データベースの作成
```
rake db:create
```

こうすることで、```config\database.yml```に書かれているsqlが、```db\```に配置される

# モデル作成  
「title」モデルの作成
```
rails generate model title
```

```app\models\title.rb```に作成したモデルに関する情報がある

# マイグレーション
```db\migrate\{作成時刻}_create_titles.rb```にデータベースのマイグレーションがある  

```
class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|

      t.string :name
      t.date :sales_date

      t.timestamps
    end
  end
end
```

こうすることで、SQLが違ってもテーブルの型を維持できる  
```rake db:migrate```を実行するとテーブルが作成される

# テストデータ
```db\seeds.rb```にテスト用の登録ファイルがある

```
# coding: utf-8

Title.create(:name => '宇宙に行った日', :sales_date => '2011-06-28')
Title.create(:name => '観察日記', :sales_date => '2011-11-14')
```

```rake db:seed```で登録

```
rails dbconsole
select * from titles;
.quit
```
で確認

# データベースのデータ取得
```app\controllers\booklist_controller.rb```を以下のように編集
```
class BooklistController < ApplicationController

  def hello
    @titles = Title.all
  end

end
```
```app\views\booklist\hello.html.erb```
```
<h1>Hello</h1>
<p>
現在登録されている本のタイトルは次のとおりです。
</p>

<p>
<% @titles.each do |title| %>
[タイトル] <%= title.name %>, [発売日] <%= title.sales_date %><br />
<% end %>
</p>
```