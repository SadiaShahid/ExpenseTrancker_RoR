module Api
  module V1
    class TransactionsController < ApiController
      # respond_to :json
      def index
        @transactions = current_user.transactions.order('created_at DESC')
      end
      def show
      end
    end
  end
end