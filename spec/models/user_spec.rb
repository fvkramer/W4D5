require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:josh) { User.create(username: "joshfillip", password: "mymediumpony") }
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
end
