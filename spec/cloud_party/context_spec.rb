# frozen_string_literal: true


class A
  include CloudParty::Context
end
describe CloudParty::Context do
  subject(:included) { A }
  describe 'creates the config correctly' do
    it 'stores the supplied email and api_key as instance variables' do
      expect(included.cfg.instance_variable_get(:@email)).to_not be_nil
      expect(included.cfg.instance_variable_get(:@api_key)).to_not be_nil
    end
  end
end
