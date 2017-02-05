require "pry"
def consolidate_cart(cart)
  unique_hash = {}
  cart.each do |item|
    item.each do |name, data|
      if unique_hash.has_key?(name)
        unique_hash[name][:count] += 1
      else
        unique_hash[name] = data
        unique_hash[name][:count] = 1
      end
    end
  end
  unique_hash
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    if cart.has_key?(coupon_hash[:item])
      if cart[coupon_hash[:item]][:count] >= coupon_hash[:num]
        remaining = cart[coupon_hash[:item]][:count] % coupon_hash[:num]  
        num_of_coupons = (cart[coupon_hash[:item]][:count] / coupon_hash[:num]).floor
        cart[coupon_hash[:item]][:count] = remaining
        cart["#{coupon_hash[:item]} W/COUPON"] = {price: coupon_hash[:cost], clearance: cart[coupon_hash[:item]][:clearance], count: num_of_coupons}
      end
    end
  end
  cart  # code here
end


def apply_clearance(cart)
  cart.each do |item, item_data|
    if item_data[:clearance] == true
      item_data[:price] = (item_data[:price]*0.8).round(1)
    end
  end
  # code here
  cart
end

def checkout(cart, coupons)
  total_cost = 0
  cart_consolidate = consolidate_cart(cart)
  cart_coupons = apply_coupons(cart_consolidate, coupons)
  cart_clearance = apply_clearance(cart_coupons)
  cart_clearance.each do |item, item_data|
    total_cost += item_data[:count] * item_data[:price]
  end
  if total_cost > 100
    total_cost = total_cost * 0.9
  end
  total_cost
end

    
  
