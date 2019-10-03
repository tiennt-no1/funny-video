RSpec.describe Vote, :type => :model do
  let (:user) {create :user}
  let (:video) {create :video, user: user}
  let (:vote) {create :vote, user: user, video: video}

  context "valid vote" do
    it 'vote like' do
      expect(vote.valid?).to be true
      expect(vote.like).to be true
    end

    it 'vote like' do
      vote.update(like: false )
      expect(vote.valid?).to be true
      expect(vote.like).to be false
    end

  end

  context "invalid vote" do
    it 'missing user' do
      vote.user = nil
      expect(vote.valid?).to be false
    end

    it 'missing video' do
      vote.video = nil
      expect(vote.valid?).to be false
    end

    it 'user only like/dislike video one time' do
      expect(vote.valid?).to be true
      vote2 = build :vote, video: video, user: user
      expect(vote2.valid?).to be false
    end

  end

end