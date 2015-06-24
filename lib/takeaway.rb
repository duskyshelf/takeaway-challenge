require 'texter'

class Takeaway

  DISHES = {:bacon => 2.50,
            :cheese => 1.00,
            :pizza => 5.00,
            :cake => 4.32,
            :carrots => 1.20,
            :pie => 2.00 }

  def initialize # consider passing in the menu-hash, rather than having it hard-coded as a constant
    @order = []
  end

  def view_dishes
    DISHES
  end

  def select_dish dish, quantity
    fail 'dish not on menu' unless on_menu? dish
    @order << [dish, quantity] # use attr_readers to access instance variables
  end

  def on_menu? dish
    DISHES.has_key?(dish)
  end

  def make_order # have this stuff in another class, OrderMaker
    puts "Choose dish and quantity (type finish to end order" # Don't use puts!
    puts "Dish?"
    dish = gets.chomp # Don't use chomp!
    if dish != 'finish'
      puts "Quantity?"
      quantity = gets.chomp
      select_dish dish.to_sym, quantity.to_i
      puts "order comes to £#{order_total}"
      make_order
    else
      make_payment
    end
  end

  def make_payment # Put this in the OrderMaker class
    puts 'Please input payment amount'
    amount = gets.chomp
    check_payment amount
  end

  def check_payment amount, texter = Texter
    unless correct? amount
      fail 'incorrect payment amount'
    else
      texter.send_message delivery_time
      'payment correct'
    end
  end

  def order_total
    order_value = 0
    @order.each do |dish| # access these via attr_readers
      order_value += DISHES[dish[0]]*dish[1]
    end
    order_value
  end

  def correct? amount
    amount == order_total
  end

  def delivery_time
    Time.now + 3600
  end

end
