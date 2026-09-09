*** Settings ***
Documentation         Create Salesforce Lead using Dynamic Test Data
Library               QForce

Suite Setup           Open Browser                about:blank             chrome
Suite Teardown        Close All Browsers

*** Test Cases ***
Create Lead - Dynamic Data

    GoTo              ${login_url}

    TypeText          username                    ${username}
    ClickText         Log In
    TypeText          password                    ${password}
    ClickText         Log In

    VerifyText        Verify Your Identity        timeout=30
    TypeText          Verification Code           ${verification_code}
    ClickText         Verify

    VerifyText        Home                        timeout=30    
    ClickText         Leads
    ClickText         New

    TypeText          First Name                  ${FirstName}
    TypeText          Last Name                   ${LastName}
    TypeText          Company                     ${Company}
    TypeText          Email                       ${Email}
    TypeText          Phone                       ${Phone}

    ClickText         Save

    VerifyText        ${FirstName} ${LastName}    timeout=30
    ClickElement      xpath=//*[text()='Show more actions']
    ClickText         Convert
    VerifyText        Convert Lead
    VerifyPickList    Converted Status            Closed - Converted
    ClickText         Convert
    VerifyText        Your lead has been converted
    ClickText         Go to Leads
    ClickText         Accounts
    Clicktext         ${Company}
    VerifyText        ${LastName}
    ClickElement      xpath=//a[normalize-space(.)='${Company}-']
    Clicktext         ${Company}
    VerifyText        ${LastName}