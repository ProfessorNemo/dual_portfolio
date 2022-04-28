module Calculation
  class << self
    def dual_portfolio(quant_rubles, quant_dollars, exchange_rate)
      eps = 0.01
      disbalance = (((quant_dollars * exchange_rate) - quant_rubles) / 2)

      return [0, (disbalance / exchange_rate).round(2)] if disbalance > eps

      return [1, (disbalance.abs / exchange_rate).round(2)] if disbalance.negative?

      [2, 0] if (disbalance < 0.01 & disbalance).positive?
    end

    def calculation_output(payment_case)
      case payment_case[0]
      when 0 then puts "Вам нужно продать #{payment_case[1]} долларов"
      when 1 then puts "Вам нужно купить #{payment_case[1]} долларов"
      when 2 then puts 'Портфель сбалансирован'
      end
    end
  end
end
