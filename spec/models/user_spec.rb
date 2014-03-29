require 'spec_helper'

describe User do
  describe 'Associations' do
    it { should have_many(:events).through(:attendances) }
  end
end
