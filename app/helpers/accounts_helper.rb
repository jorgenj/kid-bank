module AccountsHelper
  def display_amount(amount_in_pennies)
    amount_in_pennies = 0 if amount_in_pennies.nil?
    amount_in_dollars = BigDecimal.new(amount_in_pennies, 4) / 100
    "$#{amount_in_dollars.truncate(2)}"
  end
end
