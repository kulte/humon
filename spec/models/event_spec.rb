require 'spec_helper'

describe Event do
  describe 'Validations' do
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lng) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:started_at) }
  end

  describe 'Associations' do
    it { should have_many(:attendances) }
    it { should belong_to(:owner).class_name('User') }
  end
end
