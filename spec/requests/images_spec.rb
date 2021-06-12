require "rails_helper"

RSpec.describe "Images", type: :request do
  let(:params) { {} }
  let!(:animation) { create(:animation) }
  let!(:image) { create(:image, animation_id: animation.id) }

  describe "GET /api/images" do
    subject { get "/api/images", params }

    context "正常" do
      it "return 200" do
        subject
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET /api/images/random" do
    subject { get "/api/random_image", params }

    context "正常" do
      it "return 200" do
        subject
        expect(response.status).to eq(200)
      end
    end
  end
end
