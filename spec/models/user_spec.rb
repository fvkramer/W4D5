require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:josh) { User.create(username: "joshfilipp", password: "mymediumpony") }

  describe "validations" do
    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)}
    # it { should validate_presence_of(:session_token)}
    it { should validate_length_of(:password).is_at_least(6)}

    it { should validate_uniqueness_of(:username)}
    it { should validate_uniqueness_of(:session_token)}

    it { should allow_value(nil).for(:password)}

    it "sets session_token to not nil" do
      expect(josh.session_token).not_to be_nil
    end
  end

  describe "thrilling instance and class methods" do
    before(:each) { @user = User.find_by(username: "joshfilipp") }

    it "returns user when credentials found with valid parameters" do
      expect(User.find_by_credentials("joshfilipp", "mymediumpony")).to eq @user
    end

    it "returns nil if no valid user found" do
      expect(User.find_by_credentials("pony", "BIGGpony")).to be_nil
    end
  end
end
