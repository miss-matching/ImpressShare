# ImpressShare


## requirements

### markdown2impress

markdown2impressが動くかどうかチェックしましょう。

```
ruby scirpt/verify_env.rb
```

"you are ready to go with markdown2impress" と表示されれば勝ち。
エラーが表示される場合はperl,cpanm の環境を整えた後、[ここ](http://blog.glidenote.com/blog/2012/03/19/markdown2impress/)あたりを参考に頑張りましょう。

## get started

```
git clone
cd ImpressShare
bundle install --vendor/bundle
bundle exec rake db:migrate
bundle exec rake db:seed
rails s
```
you can login with ID/PASS : 'login'/'password'


