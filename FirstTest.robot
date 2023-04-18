*** Settings ***
Library    SeleniumLibrary 
Test Setup      Open Browser   ${monURL}    chrome


*** Variables ***
${monURL}   https://www.saucedemo.com/


*** Test Cases ***
Test de connexion OK
    connexion    standard_user    secret_sauce   
    verifier l'affichage de la page Products

Test de connexion utilisateur bloqué
    connexion    locked_out_user    secret_sauce
    Page Should Contain       Epic sadface: Sorry, this user has been locked out.
       




Test connexion identifiant invalid
    connexion    OUMAYMA        secret_sauce
    Page Should Contain    Epic sadface: Username and password do not match any user in this service

Test Buy a Products
    connexion    standard_user    secret_sauce   
    verifier l'affichage de la page Products
    choisir un produit
    voir le panier
    checkout
    checkout information    OUMAYMA    OUMAYMA    222     

*** Keywords ***
connexion   
    [Arguments]    ${username}    ${password}

    Input Text    id:user-name    ${username}  
    Input Password    id:password      ${password} 
    Click Button    id:login-button

verifier l'affichage de la page Products

    Page Should Contain Element    xpath://span[contains(text(),'Products')]
choisir un produit
    Click Button    id:add-to-cart-sauce-labs-backpack
voir le panier
    Click Element        id:shopping_cart_container
checkout 
    Click Element    id:checkout
checkout information
         [Arguments]    ${firstname}    ${lastname}     ${postalcode}  

    Input Text      id:first-name         ${firstname}  
    Input Password    id:last-name      ${lastname}
    Input Password    id:postal-code    ${postalcode}  
    Click Button    id:continue
