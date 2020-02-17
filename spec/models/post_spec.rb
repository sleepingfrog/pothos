require 'rails_helper'

RSpec.describe Post, type: :model do
  context "replace circled number" do

    sans_serif = "\u{1f10b}\u{2780}\u{2781}\u{2782}\u{2783}\u{2784}\u{2785}\u{2786}\u{2787}\u{2788}\u{2789}\u{1f10c}\u{278b}\u{278c}\u{278d}\u{278e}\u{278f}\u{2790}\u{2791}\u{2792}\u{2793}"
    normal = "\u{24ea}\u{2460}\u{2461}\u{2462}\u{2463}\u{2464}\u{2465}\u{2466}\u{2467}\u{2468}\u{2469}\u{24ff}\u{2776}\u{2777}\u{2778}\u{2779}\u{277a}\u{277b}\u{277c}\u{277d}\u{277e}\u{277f}"

    it "title replace sans-serif after assignment" do
      post = Post.new(title: sans_serif)
      expect(post.title).to eq(normal)
      post.save
      expect(post.title).to eq(normal)
    end

    it "body not respace after assignment" do
      post = Post.new(body: sans_serif)
      expect(post.body).to eq(sans_serif)
      post.save
      expect(post.body).to eq(sans_serif)
    end
  end
end
