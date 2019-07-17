require 'net/https'

module Episodes
  class SetEpisodesService
    def execute
      set_base_episodes

      uri = URI.parse(Settings.prism_db_api_episode_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      res = https.start { https.get(uri.request_uri) }
      if res.code == '200'
        result = JSON.parse(res.body)
        set_all_episodes(result["results"])
      else
        puts "API ERROR #{res.code} #{res.message}"
      end
    end

    private

    def set_base_episodes
      Animation.all.each do |animation|
        pp animation
        (1..animation.episode_num).to_a.each do |i|
          Episode.find_or_create(series: animation.series_name, episode_num: i, animation_id: animation.id)
        end
      end
    end

    # {"lives"=>[], "絵コンテ"=>"誌村宏明", "episodeOfSeries"=>"ipp", "アニメーション演出"=>"Nam Sung Min",
    #  "サブタイトル"=>"ゆめかわアイドル始めちゃいました！？", "ストーリーボード"=>"Nam Sung Min、An Jai Ho",
    #  "作画監修"=>"斉藤里枝、川島尚", "放送日(TXN)"=>"2017年4月4日", "演出"=>"佐藤まさふみ",
    #  "脚本"=>"加藤還一", "話数"=>1, "_key"=>"ipp_1"}
    def set_all_episodes(episodes)
      episodes.each do |e|
        episode = Episode.where(series: e['episodeOfSeries']).find_by(episode_num: e['話数'])
        next if episode.nil?
        episode.update(story_board_jp: e['絵コンテ'], animation_production: e['アニメーション演出'], subtitle: e['サブタイトル'],
                       story_board: e['ストーリーボード'], animation_supervision: e['作画監修'], broadcast_date: e['放送日(TXN)'],
                       production: e['演出'], script: e['脚本'], key: e['_key'])
      end
    end
  end
end
