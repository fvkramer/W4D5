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

    describe "::find_by_credentials" do
      context "with valid credentials" do
        it "returns user" do
          expect(User.find_by_credentials("joshfilipp", "mymediumpony")).to eq @user
        end
      end

      context "with invalid credentials" do
        it "returns nil" do
          expect(User.find_by_credentials("pony", "BIGGpony")).to be_nil
        end
      end
  end


    describe "#reset_session_token!" do
      #reset session_token
      it "resets session token" do
        old_session_token = josh.session_token
        expect(josh.reset_session_token!).not_to eq(old_session_token)
        expect(User.find_by(session_token: josh.session_token)).to eq(josh)
      end
    end
  end
end
