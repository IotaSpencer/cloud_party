# frozen_string_literal: true

describe CloudParty do
  describe '.context_connect' do
    subject(:connection) { described_class.context_connect }

    it 'should not respond to .new' do
      expect(CloudParty::Context).to_not respond_to :new
    end

    it 'returns an instance of CloudParty::Context' do
      expect(connection).to be_a(CloudParty::Context)
    end
  end
end
