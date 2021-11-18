class Graph < ApplicationRecord
  belongs_to :user
  # 一人のユーザーが同じ日付のデータを複数記録できないようにする
  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :weight, presence: true
end
