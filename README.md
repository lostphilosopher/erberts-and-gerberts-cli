# Erberts and Gerberts Command Line Interface

##Using this is simple.

**Step 1.** Make sure you have Ruby and watir-webdriver installed.

**Step 2.** Create an account on [Erberts and Gerberts](https://erbertandgerberts-delivery-1088.patronpath.com/bbLogIn.php?cmd=reg).

**Step 3.** Create a config.json with the following fields filed in (alter the order to your liking, using the menu.json file):
```
{
    "email" : "lorem@ipsum.com",
    "password" : "Secret",
    "address1" : "1234 Fake St.",
    "address2" : "Apt. 42",
    "city" : "Anywhere",
    "zip" : "12345",
    "contact" : "Amce Co",
    "sandwiches" : [{
        "name" : "titan",
        "label" : "John Doe",
        "bread" : "wheat",
        "options" : ["no mayo"]
    }],
    "soups" : [{
        "name" : "broccoli cheddar cheese",
        "size" : "cup",
        "label" : "Major Tom"
    }],
    "sides" : [{
        "name" : "original potato chips"
    }],
    "drinks" : [{
        "name" : "bottled dasani water"
    }]   
}
```
*Options supported: "no mayo"*

*Bread supported: "french", "wheat"*

**Step 4.** `ruby ryatt.rb` (make sure you have ruby and watir-webdriver installed)

**Step 5.** Hit continue.

**Step 6:** Enter your payment info.

**Step 7:** Enjoy your sandwich, AND your time savings!

*Full disclosure: I don't work for Erberts and Gerberts. I am in no way affiliated with Erberts and Gerberts. I just like their sandwiches.*