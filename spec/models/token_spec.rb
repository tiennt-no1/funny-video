RSpec.describe Token, :type => :model do
  let (:user) {create :user}
  let (:token) {create :token, user: user, token: JsonWebToken.encode(user_id: user.id)}

  context "valid token" do
    it "create succeffully" do
      expect(token.valid?).to eq true
    end
  end

  context "valid invalid token" do
    it "missing user" do
      token.user = nil
      expect(token.valid?).to eq false

      token.user_id = 999999
      expect(token.valid?).to eq false
    end

    it "missing token" do
      token.token = nil
      expect(token.valid?).to eq false
    end
  end
end