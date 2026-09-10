*** Settings ***
Documentation       Create Salesforce Lead using Dynamic Test Data
Library             QForce

Suite Setup         Open Browser                about:blank             chrome
Suite Teardown      Close All Browsers

*** Test Cases ***
Create Opportunity - Dynamic Data

    GoTo            ${login_url}

    TypeText        username                    ${username}
    ClickText       Log In
    TypeText        password                    ${password}
    ClickText       Log In

    VerifyText      Verify Your Identity        timeout=30
    TypeText        Verification Code           ${verification_code}
    ClickText       Verify

    VerifyText      Home                        timeout=30
    ClickText       Opportunities
    ClickText       New

    TypeText        Opportunity Name            ${OpportunityName}
    TypeText        Close Date                  9/15/2026
    ClickElement    xpath=//label[contains(normalize-space(.),'Stage')]/following::button[1]
    ClickText       Prospecting
    ClickText       Save
    VerifyText      ${OpportunityName}

    ClickElement    xpath=//a[@title="Show 2 more actions"]
    ClickText       Add Products
    VerifyText      Add Products

