module Images
  class SearchImagesService
    def initialize(q)
      @queries = q.nil? ? [] : q.split
    end

    def execute
      images = Image.includes(:animation, :characters)
      images.where(id: image_ids)
    end

    private

      def image_ids
        @image_ids ||= (
          image_ids_by_image_info +
          image_ids_by_character_images +
          image_ids_by_animations
        ).uniq
      end

      def image_ids_by_image_info
        @image_ids_by_image_info ||= @queries.map { |query| search_images_by_image_info(query).pluck(:id) }.flatten
      end

      def search_images_by_image_info(query)
        Rails.cache.fetch("search_images_#{query}", expired_in: 60.minutes) do
          Image.where("line LIKE ?", "%#{query}%").or(Image.where("description LIKE ?", "%#{query}%"))
        end
      end

      def image_ids_by_animations
        @image_ids_by_animations ||= @queries.map { |query| search_images_by_animations(query).pluck(:id) }.flatten
      end

      def search_images_by_animations(query)
        Rails.cache.fetch("search_animations_#{query}", expired_in: 60.minutes) do
          animations = Animation.where("name LIKE ?", "%#{query}%")
          Image.where(animation_id: animations.map(&:id))
        end
      end

      def image_ids_by_character_images
        @image_ids_by_character_images ||= search_character_images.pluck(:image_id).flatten
      end

      def search_character_images
        Rails.cache.fetch("search_image_characters_#{@queries}", expired_in: 60.minutes) do
          CharacterImage.where(character_id: character_ids)
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
