module Morningstar
  class Portfolios < Base
    attr_reader :portfolio

    def initialize(portfolio)
      @portfolio = portfolio
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
