# Requirements
- Opencart 2.0.x to 2.2.x / 2.3.x / 3.x
- Active seller account with PagHiper - https://paghiper.com

# Installation guide PagHiper Pix module for Opencart

1 - Download the files of the modules according to their Opencart versions (below) on your PC, remembering that the version must be compatible exactly with the version of your store, if you don't know the correct one, access the admin of your store at the bottom of the same display, there is no backward compatibility between some versions of Opencart modules.

- For Opencart 2.0.x, 2.1.x and 2.2.x
https://github.com/loja5combr/Modulos-PagHiper-Pix-Opencart/blob/main/PagHiper%20Pix%201.0%20-%20Opencart%202.0.x%20a%202.2.x.zip
- For Opencart 2.3.x
https://github.com/loja5combr/Modulos-PagHiper-Pix-Opencart/blob/main/PagHiper%20Pix%201.0%20-%20Opencart%202.3.x.zip
- For Opencart 3.x
https://github.com/loja5combr/Modulos-PagHiper-Pix-Opencart/blob/main/PagHiper%20Pix%201.0%20-%20Opencart%203.x.zip

2 - With the files downloaded and unzipped on your PC, access your store's files using an FTP client of your choice, if you don't have an FTP client which you already use, we recommend [Filezilla] (https://loja5.zendesk.com/ hc / en / articles / 360024298972-How-to-use-FTP-with-FileZilla), access your server in the main directory of your store, after that send the module files according to the version (previously unzipped) which you want to use, be careful not to send from other versions.

<i> Ps: Remembering that FTP access data to your store is provided by your hosting, in many cases the data is the same as Cpanel's. </i>

! [Access Bar] (https://i.imgur.com/gVooTdD.png)

3 - After accessing and sending the module files correctly to the main directory of your store, access the administrative panel of your store, usually the path is http://www.sualoja.com.br/admin/ and the login and password have been previously registered.

<i> Ps: If the admin of your store is renamed, the original admin files for the module must be sent to the folder which corresponds to the admin in your store. </i>

! [Admin] (https://i.imgur.com/eidEAe2.png)

4 - After accessing your store's Admin, go to the <b> Extensions> Modifications </b> menu and in the upper right corner click on the button to reload changes.

! [Reload modifications] (https://i.imgur.com/wX2Z78a.png)

- We always recommend backing up if your store has any specific customization.
- [In Opencart 3.x there is a cache of templates that should be cleared whenever any store template is modified and the modifications are reloaded, it is accessed in the Admin of your store on the homepage and upper right corner, click on the icon that will display the option to clear the template cache] (https://i.imgur.com/vOTgAsn.png).

5 - Still in the administrative panel of your store, access the menu <b> Extensions> Payment </b> locate and install the <b> PagHiper Pix </b> module, if it does not show in the list, check if the previous steps have been done correctly, mainly the part of sending the files to the server.

6 - After installed correctly, click on Edit its configuration, it will display the configuration screen where you will ask for your credentials with PagHiper, access your PagHiper account in the menu [<b> My Account> Credentials </b>] ( https://www.paghiper.com/painel/credencial/) will obtain the data which will be configured in the module in your store.

- The customized fields will be according to the customer's store, only configure them if your store has them.
- Read and follow the instructions detailed in each module configuration field.

! [Configuration 1] (https://i.imgur.com/QRfbDDB.png)
! [Configuration 2] (https://i.imgur.com/drAJVUV.png)

7 - Configured the module correctly according to your account data and the instructions displayed in each field save the settings, this is done, just test in case of errors the logs of the same are saved in the Admin of your store in <b> Sales or Orders> PagHiper Pix> Logs </b> with the reason for it, remembering that the module is API, therefore your store must maintain the customer database correctly registered.

8 - The data return is done automatically when a payment slip is paid / canceled / returned, so there is no need to configure any url next to the PagHiper system, the module already does the process automatically.

# Viewing Pix Store Orders
To view and consult pix orders placed in the store, access the menu <u> Sales or Orders> PagHiper Pix> Orders </u>, so you can consult and view orders placed in your store via PagHiper Pix.
! [Orders] (https://i.imgur.com/V1YM7sv.png)

# Applying Discounts to PagHiper Pix

1 - Download the discount module by payment method at Opencart.com, for this [Click Here] (https://www.opencart.com/index.php?route=marketplace/extension/info&extension_id=21685&filter_search=desconto&filter_license=0 ) and directly access the module link and download it to your PC.

2 - Access the Admin of your store and in the menu <b> Extensions> Installer </b> and 
