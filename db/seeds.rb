# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テストユーザー情報
EMAIL = 'test@example.com'
PASSWORD = 'password'

# データの入力範囲
START_DATE = Date.today - 11.months
END_DATE = Date.today + 1.months

# 1/(NO_RECORD_CONSTANT)の確率でデータを記録しない
# （記録が一部欠けていてもグラフが正常に描けるかをチェックするため）
NO_RECORD_CONSTANT = 5

# 記録する体重の範囲（乱数で値を決める都合上,10倍しておく）
MIN_WEIGHT = 600
MAX_WEIGHT = 620
DIV_CONSTANT = 10

# テストユーザーが存在しないときだけ作成し,変数名をuserとする
user = User.find_or_create_by!(email: EMAIL) do |user|
  user.password = PASSWORD
  puts 'テストユーザーの初期データインポートに成功しました。'
end

user.graphs.destroy_all

graphs = []
(START_DATE..END_DATE).each do |date|
  #1/(NO_RECORD_CONSTANT) の確率でデータを入れる操作をスキップ
  next if rand(NO_RECORD_CONSTANT).zero?
  graphs << {
    user_id: user.id,
    date: date,
    # to_f を入れておかないと整数になるので注意!
    weight: rand(MIN_WEIGHT..MAX_WEIGHT).to_f / DIV_CONSTANT
  }
end
Graph.create!(graphs)
puts '体重の初期データ投入に成功しました！'