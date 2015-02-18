require 'watir-webdriver'
require 'json'

# Parse config settings
if !File.file?("config.json")
    abort('Error: No config file (config.json) found.')
end
file = File.open("config.json", "rb")
contents = file.read
file.close
config = JSON.parse(contents)

# Validate confg settings
if config['email'].nil?
    abort('Error: confg[\'email\'] is undefined')
end
if config['password'].nil?
    abort('Error: confg[\'password\'] is undefined')
end

# Parse order file, default or command line parameter
if !ARGV[0]
    puts "Using default order file: orders/default.json"  
    if File.file?("orders/default.json")
        file = File.open("orders/default.json", "rb")
    else
        abort('Error: The default order file (orders/default.json) has not been created!')
    end    
else
    if File.file?("orders/#{ARGV[0]}")
        puts "Using order file: orders/#{ARGV[0]}"
        file = File.open("orders/#{ARGV[0]}", "rb")
    else
        abort("Error: File with name orders/#{ARGV[0]} does not exist!")
    end
end
contents = file.read
file.close
order = JSON.parse(contents)

# Validate order info
if order['address1'].nil?
    abort('Error: order[\'address1\'] is undefined')
elsif order['city'].nil?
    abort('Error: order[\'city\'] is undefined')
elsif order['state'].nil?
    abort('Error: order[\'state\'] is undefined')
elsif order['zip'].nil?
    abort('Error: order[\'zip\'] is undefined')
elsif order['address2'].nil?
    order['address2'] = ""
end

# Parse the menu file
file = File.open("menu.json", "rb")
contents = file.read
file.close
menu = JSON.parse(contents)

# Open browser
@b = Watir::Browser.new :ff

# Go to Erberts and Gerberts Login page
@b.goto "https://erbertandgerberts-delivery-1088.patronpath.com/bbLogIn.php"

# Login
@b.text_field(:name => 'Email').set config['email']
@b.text_field(:name => 'Password').set config['password']
@b.button(:title => 'Login').click

# Enter the CaringBridge address
@b.text_field(:name => 'check_address').set order['address1']
@b.text_field(:name => 'check_address2').set order['address2']
@b.text_field(:name => 'check_city').set order['city']
@b.text_field(:name => 'check_zip').set order['zip']
@b.select_list(:name => 'check_state').select_value(order['state'])
@b.img(:title => 'Check Address').click
@b.execute_script "window.alert = function() { return true; }"

# Yes twice, for reasons
@b.button(:title => 'Continue').click
@b.button(:title => 'Continue').click

# Order sandwiches
if !order['sandwiches'].nil?
    order['sandwiches'].each do |item|
        puts "Ordering: #{item['name']}"

        validOrder = true

        case item['name']
            when "apollo"
                @b.goto menu['sandwiches']['apollo']
            when "pompeii"
                @b.goto menu['sandwiches']['pompeii']
            when "spartan"
                @b.goto menu['sandwiches']['spartan']
            when "erupter"
                @b.goto menu['sandwiches']['erupter']
            when "quatro"
                @b.goto menu['sandwiches']['quatro']
            when "titan"
                @b.goto menu['sandwiches']['titan']
            when "narmer"
                @b.goto menu['sandwiches']['narmer']
            when "tullius"
                @b.goto menu['sandwiches']['tullius']
            when "flash"
                @b.goto menu['sandwiches']['flash']
            when "shortcake"
                @b.goto menu['sandwiches']['shortcake']
            when "girf"
                @b.goto menu['sandwiches']['girf']
            when "comet candy"
                @b.goto menu['sandwiches']['comet candy']
            when "giza"
                @b.goto menu['sandwiches']['giza']
            when "boney billy"
                @b.goto menu['sandwiches']['boney billy']
            when "comet morehouse"
                @b.goto menu['sandwiches']['comet morehouse']
            when "jacob bluefinger"
                @b.goto menu['sandwiches']['jacob bluefinger']
            when "halleys comet"
                @b.goto menu['sandwiches']['halleys comet']
            when "tappy"
                @b.goto menu['sandwiches']['tappy']
            when "bornk"
                @b.goto menu['sandwiches']['bornk']
            when "pudder"
                @b.goto menu['sandwiches']['pudder']
            else
                validOrder = false
                puts "NAS: #{item['name']} is not a sandwhich"
        end

        # If the order is valud, place it
        if validOrder
            # Sandwich options
            if  !item['options'].nil? && (item['options'].include? 'no mayo')
                @b.checkbox(:id => 'box1-0').set            
            end
            if item['bread'] == "wheat"
                @b.select_list(:id => 'item_options[]').select_value('099a429f2f463b6a0078d6cc9c7844bd')
            else 
                @b.select_list(:id => 'item_options[]').select_value('b6c1e8343d2198110a6de554fba7bac5')
            end

            if !item['label'].nil?
                @b.text_field(:name => 'label').set item['label']
            end

            @b.button(:id => 'AddToPlate').click 
        end 
    end
end

# Order soups
if !order['soups'].nil?
    order['soups'].each do |item|
        puts "Ordering: #{item['name']}"

        validOrder = true

        case item['name']
            when "minnesota wild rice"
                @b.goto menu['soups']['minnesota wild rice']        
            when "wisconsin beer cheese"
                @b.goto menu['soups']['wisconsin beer cheese']        
            when "broccoli cheddar cheese"
                @b.goto menu['soups']['broccoli cheddar cheese']
            when "fiery sw chilli"
                @b.goto menu['soups']['fiery sw chilli']
            else
                validOrder = false            
                puts "NAS: #{item['name']} is not a soup"
        end

        # If the order is valud, place it
        if validOrder
            # Size
            if item['size'] == "bowl"
                @b.select_list(:id => 'item_options[]').select_value('8a111aafe2d284595cd6389e7de51d8e')
            else 
                @b.select_list(:id => 'item_options[]').select_value('28e90113ff0165a922ad0a70d0b247f6')    
            end 

            if !item['label'].nil?
                @b.text_field(:name => 'label').set item['label']
            end

            @b.button(:id => 'AddToPlate').click          
        end
    end
end

# Sides
if !order['sides'].nil?
    order['sides'].each do |item|
        puts "Ordering: #{item['name']}"

        validOrder = true

        case item['name']
            when "baked original potato chips"
                @b.goto menu['sides']['baked original potato chips']
            when "cheese curls"
                @b.goto menu['sides']['cheese curls']
            when "jalapeno potato chips"
                @b.goto menu['sides']['jalapeno potato chips']
            when "nacho tortilla"
                @b.goto menu['sides']['nacho tortilla']
            when "original potato chips"
                @b.goto menu['sides']['original potato chips']
            when "salt and vinegar potato chips"
                @b.goto menu['sides']['salt and vinegar potato chips']
            when "sour cream and onion potato chips"
                @b.goto menu['sides']['sour cream and onion potato chips']
            when "fresh baked chocolate chunk cookie"
                @b.goto menu['sides']['fresh baked chocolate chunk cookie']
            when "dozen cookies"
                @b.goto menu['sides']['dozen cookies']
            when "peanut butter crispy dessert bar"
                @b.goto menu['sides']['peanut butter crispy dessert bar']
            when "dozen peanut butter crispy dessert bars"
                @b.goto menu['sides']['dozen peanut butter crispy dessert bars']
            when "giant deli pickle"
                @b.goto menu['sides']['giant deli pickle']
            else
                validOrder = false               
                puts "NAS: #{item['name']} is not a side"
        end    

        # If the order is valud, place it
        if validOrder
            @b.button(:id => 'AddToPlate').click
        end      
    end
end

# Drinks
if !order['drinks'].nil?
    order['drinks'].each do |item|
        puts "Ordering: #{item['name']}"

        validOrder = true

        case item['name']
            when "bottled coke"
                @b.goto menu['drinks']['bottled coke']
            when "bottled diet coke"
                @b.goto menu['drinks']['bottled diet coke']
            when "bottled minute maid lemonade"
                @b.goto menu['drinks']['bottled minute maid lemonade']
            when "bottled sprite"
                @b.goto menu['drinks']['bottled spritee']
            when "bottled dasani water"
                @b.goto menu['drinks']['bottled dasani water']                                    
            else
                validOrder = false               
                puts "NAD: #{item['name']} is not a drink"            
        end

        # If the order is valud, place it
        if validOrder
            @b.button(:id => 'AddToPlate').click
        end        
    end
end

# Go to checkout page
@b.goto "https://erbertandgerberts-delivery-1088.patronpath.com/checkout.php"
if !order['contact'].nil?
    @b.text_field(:name => 'contactname').set order['contact']
end

# Read order total
orderTotal = @b.tds(:class, 'myorder_total_line')[1].text
orderTotal = orderTotal.delete('$').to_f
puts "Order total: $#{orderTotal}"
tip = (orderTotal * 0.2).round(2)
puts "Suggested tip: $#{tip}"
total = orderTotal + tip
total = total.round(2)
puts "Total: $#{total}"
# Add integration with Twitter
#puts "Tweet about it: https://twitter.com/intent/tweet?button_hashtag=CommandFood&text=I%20just%20ordered%20Eberts%20and%20Gerberts%20from%20the%20command%20line"

# If desired, allow the user to enter their payment info as well
if order['allow payment'] && config['payment']
    # Check for Erberts and Gerberts errors
    if @b.td(:class, 'contenterror').exists?
        abort('Error: Their are errors on the page.')
    end
    @b.button(:title => 'Continue').click

    puts "Setting up payment via #{order['payment type']}" 

    # Input credi card info
    if order['payment type'] == 'credit card'
        # Validate credit card info
        if config['payment']['accountnumber'].nil?
            abort('Error: config[\'payment\'][\'accountnumber\']')
        elsif config['payment']['seccode'].nil?
            abort('Error: config[\'payment\'][\'seccode\']')
        elsif config['payment']['CCType'].nil?
            abort('Error: config[\'payment\'][\'CCType\']')
        elsif config['payment']['month'].nil?
            abort('Error: config[\'payment\'][\'month\']')
        elsif config['payment']['year'].nil?
            abort('Error: config[\'payment\'][\'year\']')
        elsif config['payment']['cardname'].nil?
            abort('Error: config[\'payment\'][\'cardname\']')
        elsif config['payment']['cardstreet'].nil?
            abort('Error: config[\'payment\'][\'cardstreet\']')
        elsif config['payment']['cardcity'].nil?
            abort('Error: config[\'payment\'][\'cardcity\']')
        elsif config['payment']['cardstate'].nil?
            abort('Error: config[\'payment\'][\'cardstate\']')
        elsif config['payment']['cardzip'].nil?
            abort('Error: config[\'payment\'][\'cardzip\']')
        elsif config['payment']['cardphone'].nil?
            abort('Error: config[\'payment\'][\'cardphone\']')
        elsif config['payment']['ConfPhone'].nil?
            abort('Error: config[\'payment\'][\'ConfPhone\']')
        end

        @b.radio(:name => 'paytype', :value => 'cc').set
        @b.text_field(:name => 'accountnumber').set config['payment']['accountnumber']
        @b.text_field(:name => 'seccode').set config['payment']['seccode']
        @b.select_list(:id => 'CCType').select_value(config['payment']['CCType'])
        @b.select_list(:name => 'month').select_value(config['payment']['month'])
        @b.select_list(:name => 'year').select_value(config['payment']['year'])
        @b.text_field(:name => 'cardname').set config['payment']['cardname']
        @b.text_field(:name => 'cardstreet').set config['payment']['cardstreet']
        @b.text_field(:name => 'cardcity').set config['payment']['cardcity']
        @b.select_list(:name => 'cardstate').select_value(config['payment']['cardstate'])
        @b.text_field(:name => 'cardzip').set config['payment']['cardzip']
        @b.text_field(:name => 'cardphone').set config['payment']['cardphone']
    else
        @b.radio(:name => 'paytype', :value => 'cash').set
        @b.text_field(:name => 'ConfPhone').set config['payment']['ConfPhone']
    end
end

puts "Final step(s) must be completed manually. Enjoy your Erbs!"