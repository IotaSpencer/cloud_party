require 'httparty'
module CloudParty
  module Node
    def self.included(base)
      base.include(HTTParty)
      puts base.to_s
    end
  end
end