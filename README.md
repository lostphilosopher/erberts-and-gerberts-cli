# Erberts and Gerberts Command Line Interface

##Using this is simple.

**Step 1.** Make sure you have Ruby, watir-webdriver, and Firefox installed.

**Step 2.** Create an account on [Erberts and Gerberts](https://erbertandgerberts-delivery-1088.patronpath.com/bbLogIn.php?cmd=reg).

**Step 3.** Create a config.json with the following fields filled in:
```
{
    "email" : "foo@bar.com",
    "password" : "Secret",
    "payment" : {
        "accountnumber" : "0000 0000 0000 0000",
        "seccode" : "000",
        "CCType" : "1",
        "month" : "10",
        "year" : "2020",
        "cardname" : "JOHN DOE",
        "cardstreet" : "123 Fake St.",
        "cardcity" : "Cityville",
        "cardstate" : "MN",
        "cardzip" : "00000",
        "cardphone" : "123 456 7890",
        "ConfPhone" : "123 456 7890"
    }
}
```

*NOTE: Never store config.json on a public repo! It is under .gitignore and should stay that way.*

**Step 4.** Create an orders/default.json file with your "usual" Erberts and Gerberts order and delivery address filled in (use orders/example.json and menu.json as a guide) **NOTE:** Make sure you use an address within the Erberts and Gerberts delivery area. The script will fail on orders outside of delivery range.

*payment type supported: "credit card", "pay on delivery"*

*sandwich options supported: "no mayo"*

*sandwich bread supported: "french", "wheat"*

*soup size supported: "cup", "bowl"*

**Step 5.** `ruby erbs.rb` (this will place the default.json order)

**Step 5.** If you have `allow payment` set to `true` the script will take you to the payment page and fill in the information you provided. *NOTE: The script will not actually place the order, you must manually click continue!* If you have `allow payment` set to false you will have to complete the rest of the process manually.

**Step 6:** Enjoy your sandwich, AND your time savings!

**Using multiple order files:** You can create multiple order files and store them in orders/. To use an alternate order file type `ruby erbs.rb alternate_order_file_name.json` in Step 5. If no order file is provided the script will always fall back to orders/default.json.

*Full disclosure: I don't work for Erberts and Gerberts. I am in no way affiliated with Erberts and Gerberts. I just like their sandwiches.*

**Known issues:** 

- This script is architected like an amateur Rubyist wrote it in a couple hours. 
- There should be testing of some kind.
- There is only basic error handling.
- Many menu options are not yet supported.
- Occasionally the Erberts and Gerberts website hangs and the script will fail. That could probably be handled better.


*Questions? | Comments? | Feedback? - wandersen02@gmail.com* 