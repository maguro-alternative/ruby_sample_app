# coding: utf-8
# 日本語を使う場合、上記がないとrails側でエラーが起きる
class BooklistController < ApplicationController

    def hello
        # 変数の受け渡し
        @msg = 'こんにちは。お久しぶりです。';
        @titles = Title.all
        render :text => 'Hello!'
    end
    
    public :hello

    def bye
        render :text => 'bye!'
    end

    public :bye

end
