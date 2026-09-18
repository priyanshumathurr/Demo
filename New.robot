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
    SelectDropdown    name=StageName    Prospecting
    ClickText           Save
    WaitUntilPageLoaded

    VerifyText           ${OpportunityName}
    VerifyText           Prospecting

    ${oppUrl}=    GetURL
    Log    Opportunity created at: ${oppUrl}
    
    ClickText           Related
    WaitUntilPageLoaded
    ClickText           Add Product
    WaitUntilPageLoaded
    VerifyText           Add Products

    @{products}=    Create List    GenWatt Diesel 1000kW    GenWatt Propane 500kW    Installation: Portable

    FOR    ${product}    IN    @{products}
        TypeText    css=input[placeholder='Search Products...']    ${product}
        Wait Until Element Is Visible    xpath=//a[text()='${product}']    timeout=5s
        ClickElement    xpath=//tr[.//a[text()='${product}']]//input[@type='checkbox']
    END

    ClickText           Next
    WaitUntilPageLoaded
    VerifyText           Products
