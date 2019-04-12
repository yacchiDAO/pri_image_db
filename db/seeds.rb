# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者
Admin.create(login_id: 'admin', password: 'password', password_confirmation: 'password')



# 作品
animation_list = ['プリティーリズムオーロラドリーム',
                  'プリティーリズムディアマイフューチャー',
                  'プリティーリズム・レインボーライブ',
                  'プリパラ',
                  'アイドルタイムプリパラ',
                  'キラッと☆プリチャン',
                  'KING OF PRISM']
animation_list.each do |a|
  Animation.create(name: a)
end

# キャラクター

# オーロラドリーム
ad_character_list =
  ['春音あいら',
   '天宮りずむ',
   '高峰みおん',
   'ショウ',
   'ヒビキ',
   'ワタル',
   '滝川純',
   '阿世知今日子',
   '城之内セレナ',
   '藤堂かのん',
   '久里須かなめ',
   'ペアチアマスコット']
ad_character_list.each do |c|
  character = Character.create(name: c)
  CharacterAnimation.create(character_id: character.id, animation_id: 1)
end

# ディアマイフューチャー
dmf_character_list =
  ['上葉みあ',
   '深山れいな',
   '志々美かりん',
   '大瑠璃あやみ',
   'ヘイン',
   'ソミン',
   'シユン',
   'チェギョン',
   'ジェウン',
   '春音いつき',
   'ヨンファ',
   'ユンス',
   'ドン・ボンビー',
   'ペアチャム']
dmf_character_list.each do |c|
  character = Character.create(name: c)
  CharacterAnimation.create(character_id: character.id, animation_id: 2)
end

# レインボーライブ
rl_character_list =
  ['彩瀬なる',
   '福原あん',
   '涼野いと',
   '蓮城寺べる',
   '小鳥遊おとは',
   '森園わかな',
   'りんね',
   '神浜コウジ',
   '速水ヒロ',
   '仁科カヅキ',
   '荊千里/モモ',
   'DJ.Coo',
   '氷室聖',
   '法月仁',
   '黒川冷',
   'ペアとも']
rl_character_list.each do |c|
  character = Character.create(name: c)
  CharacterAnimation.create(character_id: character.id, animation_id: 3)
end

# プリパラ
para_character_list =
  ['真中らぁら',
   '南みれぃ',
   '北条そふぃ',
   '東堂シオン',
   'ドロシー・ウェスト',
   'レオナ・ウェスト',
   '黒須あろま',
   '白玉みかん',
   'ガァルル',
   '紫京院ひびき',
   'ファルル',
   '緑風ふわり',
   '真中のん',
   '月川ちり',
   '太陽ペッパー',
   '北条コスモ',
   '黄木あじみ',
   '鍋島ちゃん子',
   'ジュルル/ジュリィ',
   'ジャニス',
   'マスコット',
   'めが姉ぇ',
   'めが兄ぃ',
   '愛媛なお',
   '安藤玲']
para_character_list.each do |c|
  character = Character.create(name: c)
  CharacterAnimation.create(character_id: character.id, animation_id: 4)
end

# アイドルタイムプリパラ
ip_character_list =
  ['夢川ゆい',
   '虹色にの',
   '幸多みちる',
   '華園しゅうか',
   'ファララ・ア・ラーム',
   'ガァララ・ス・リープ',
   '地獄ミミ子',
   '夢川ショウゴ',
   '三鷹アサヒ',
   '高瀬コヨイ',
   '華園みあ']
ip_character_list.each do |c|
  character = Character.create(name: c)
  CharacterAnimation.create(character_id: character.id, animation_id: 5)
end

# キラッと☆プリチャン
pc_character_list =
  ['桃山みらい',
   '萌黄えも',
   '青葉りんか',
   '赤城あんな',
   '緑川さら',
   '紫藤める',
   '白鳥アンジュ',
   '七星あいら',
   '金森まりあ',
   '黒川すず',
   'だいあ',
   '歩堂デヴィ',
   '明日香ルゥ',
   '青葉ユヅル',
   '桃山ひかり'
]

# キングオブプリズム
kp_character_list =
  ['一条シン',
   '太刀花ユキノジョウ',
   '香賀美タイガ',
   '十王院カケル',
   '鷹梁ミナト',
   '西園寺レオ',
   '涼野ユウ',
   '如月ルヰ',
   '大和アレクサンダー',
   '山田リョウ']
kp_character_list.each do |c|
  character = Character.create(name: c)
  CharacterAnimation.create(character_id: character.id, animation_id: 7)
end


# その他
character = Character.create(name: 'その他')
[1, 2, 3, 4, 5, 6].each do |i|
  CharacterAnimation.create(character_id: character.id, animation_id: i)
end
