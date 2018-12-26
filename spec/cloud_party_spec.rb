# frozen_string_literal: true

describe CloudParty do
  describe '.connect_with' do
    subject(:connection) { described_class.connect_with('bear@dog.com', 'superapikey') }

    it 'creates an instance of RubyFlare::Connect with passed arguments' do
      expect(CloudParty::Connect).to receive(:new).with('bear@dog.com', 'superapikey')
      connection
    end

    it 'returns an instance of CloudParty::Connect' do
      expect(connection).to be_a(CloudParty::Connect)
    end
  end
end
