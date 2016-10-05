module Morningstar
  class Users < Base
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def create
      query({
        :endpoint => '',
        :method => :POST,
        :headers => {
          :authorization => 'username=' + 'fill_in_here'+ ',password=' + 'fill_in_here'
        }
      })
    end

    def update
      # TODO
    end

    def destroy
      # TODO
    end
    
  end
end
