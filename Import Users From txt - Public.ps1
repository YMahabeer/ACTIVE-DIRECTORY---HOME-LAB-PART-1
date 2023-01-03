#Use this script to import usernames from .txt file into Active Directory

#----------- Variables ----------------------#

#This is default password that users will use to log into their account for the first time.
#To maintain security; you enter the password into command prompt so it is not stored in plain text at any point.
#Need to force users to create new a password on logon after using this default password.
$Default_Secured_Password = Read-Host -AsSecureString
Write-Host $Default_Secured_Password

#This variable stores users first and last name from the text file.
#change the path and file name as needed to match the .txt file you are using.
$User_First_Last_List= Get-Content -Path .\"random name list.txt"
Write-Host "Names read are:"
Write-Host $User_First_Last_List

#----------- Script ----------------------#

#Creates new Organizational Unit named _ImportedUsers to store the imported users.
New-ADOrganizationalUnit -Name "_Imported Users" -ProtectedFromAccidentalDeletion $false
Write-Host "_Imported Users O.U created"

#Loop for processing each user name and setting up their user profile.
    #Processes the .txt file of random names to generate first name, last name, and usernames.
    $User_First_Last_List | ForEach-Object {
        $First_Name = $_.Split(" ")[0].ToLower()
        $Last_Name = $_.Split(" ")[1].ToLower()
        $Full_Name = -join ($First_Name, " ", $Last_Name)
        $User_Name = -join ($First_Name,".", $Last_Name)
        $SAM_UN = -join ($First_Name[0],".", $Last_Name)
        Write-Host "Creating: $($Full_Name)"
        
        #Executes adding the user to Active Directory and all of their related properties.
        New-ADUser -Name $Full_Name `
            -GivenName $First_Name `
            -Surname $Last_Name `
            -DisplayName $Full_Name `
            -UserPrincipalName $User_Name `
            -SamAccountName $SAM_UN `
            -AccountPassword $Default_Secured_Password `
            -ChangePasswordAtLogon $true `
            -Type "User" `
            -Enabled $true `
            -Path "ou=_Imported Users, dc=CompanyName, dc=com" `
    }

#----------- End Of Script ----------------------#


#----------- Notes ----------------------#



