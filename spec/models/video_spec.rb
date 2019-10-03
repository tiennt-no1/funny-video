RSpec.describe Video, :type => :model do
  let(:video) {create :video, user: create(:user)}
  context "valid video" do
    it 'should success fully' do
      expect(video.valid?).to eq true
    end
  end

  context "invalid video" do
    it 'missing share user' do
      video.user = nil
      expect(video.valid?).to eq false
    end

    it 'missing youtube_url' do
      video.youtube_url = nil
      expect(video.valid?).to eq false
    end

    it 'invalid youtube_url(missing youtube id)' do
      video.youtube_url = 'fslkfsjdlkfjdslk'
      expect(video.valid?).to eq false

      video.youtube_url = 'https://medium.com/@lukepierotti/setting-up-rspec-and-factory-bot-3bb2153fb909'
      expect(video.valid?).to eq false

      video.youtube_url = 'https://www.youtube.com/watch?v=VmGYyhs5V6c'
      expect(video.valid?).to eq true

      video.youtube_url = 'https://youtu.be/VmGYyhs5V6c'
      expect(video.valid?).to eq true
    end

    it 'test format youtube url ' do
      video.youtube_url = 'https://www.youtube.com/watch?v=VmGYyhs5V6c'
      expect(video.valid?).to eq true

      video.save
      expect(video.youtube_url).to eq "https://www.youtube.com/embed/VmGYyhs5V6c"
    end
  end
end