module Images
  class SearchImagesService
    def initialize(q)
      @queries = q.nil? ? [] : q.split(' ')
    end

    def execute
      # Animation name -> animation_ids
      # Character name -> character_ids -> image_ids
      # Image.line
      # Image.description
      # Image と ImageCharacterを結合

      images = Image.includes(:animation, :characters)
      query = {}
      query[:animation_id] = animation_ids if animation_ids.present?
      query[:characters] = { id: character_ids }  if character_ids.present?
      query[:id] = image_ids if image_ids.present?
      images.where(query)
    end

    private

    def image_ids
      @image_ids ||= @queries.map { |query| search_images(query).pluck(:id) }.flatten.uniq
    end

    def search_images(query)
      Rails.cache.fetch("search_animations_#{query}", expired_in: 60.minutes) do
        Image.where("line LIKE ?", "%#{query}%").or(Image.where("description LIKE ?", "%#{query}%"))
      end
    end

    def animation_ids
      @animation_ids ||= @queries.map { |query| search_animations(query).pluck(:id) }.flatten.uniq
    end

    def search_animations(query)
      Rails.cache.fetch("search_animations_#{query}", expired_in: 60.minutes) do
        Animation.where("name LIKE ?", "%#{query}%")
      end
    end

    def character_ids
      @character_ids ||= @queries.map { |query| search_characters(query).pluck(:id) }.flatten.uniq
    end

    def search_characters(query)
      Rails.cache.fetch("search_characters_#{query}", expired_in: 60.minutes) do
        Character.where("name LIKE ?", "%#{query}%")
      end
    end
  end
end
