require 'watir-webdriver'
require 'json'

# Parse config settings
file = File.open("config.json", "rb")
contents = file.read
file.close
config = JSON.parse(contents)

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
            if item['options'].include? 'no mayo'
                @b.checkbox(:id => 'box1-0').set            
            end
            if item['bread'] == "wheat"
                @b.select_list(:id => 'item_options[]').select_value('099a429f2f463b6a0078d6cc9c7844bd')
            else 
                @b.select_list(:id => 'item_options[]').select_value('b6c1e8343d2198110a6de554fba7bac5')
            end

            @b.text_field(:name => 'label').set item['label']

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
            @b.text_field(:name => 'label').set item['label']

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
@b.text_field(:name => 'contactname').set order['contact']

# If desired, allow the user to enter their payment info as well
# @todo: Select Pay at delivery vs Credit card
if order['allow payment']
    @b.button(:title => 'Continue').click

    puts "Setting up payment via #{order['payment type']}" 

    if order['payment type'] == 'credit card'
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
        @b.text_field(:name => 'cardstreet').set config['payment']['cardstreet']
        @b.text_field(:name => 'cardzip').set config['payment']['cardzip']
        @b.text_field(:name => 'cardphone').set config['payment']['cardphone']
    else
        @b.radio(:name => 'paytype', :value => 'cash').set
        @b.text_field(:name => 'ConfPhone').set config['payment']['ConfPhone']
    end
end

puts "Final step(s) must be completed manually. Enjoy your Erbs!"