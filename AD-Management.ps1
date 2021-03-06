#requires -version 4
<#
.SYNOPSIS
  A script to conduct AD Management tasks
.DESCRIPTION
  This script is for the mangement of Active Directory. It is controlled through a CLI menu system.
.PARAMETER <Parameter_Name>
  None
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.0.4
  Author:         Acidcrash376
  Creation Date:  02/03/2020
  Purpose/Change: Initial script development
  Web:            https://github.com/acidcrash376/AD-Management/
.EXAMPLE
  ./AD-Management.ps1
  
#>

#---------------------------------------------------------[Script Parameters]------------------------------------------------------

Param (
  #Script parameters go here
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#Import Modules & Snap-ins

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Any Global Declarations go here
$script:password = $null
$script:SecurePassword = $null
#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#
Function <FunctionName> {
  Param ()
  Begin {
    Write-Host '<description of what is going on>...'
  }
  Process {
    Try {
      <code goes here>
    }
    Catch {
      Write-Host -BackgroundColor Red "Error: $($_.Exception)"
      Break
    }
  }
  End {
    If ($?) {
      Write-Host 'Completed Successfully.'
      Write-Host ' '
    }
  }
}
#>

function Test-Password {
Param ()
Begin {
    Write-Host "Display Last Generated Password"
    }
Process {
    Try {
        ###########
        #Variables#
        ###########

       $script:SecurePassword
       $script:password
        }
        Catch {
      Write-Host -BackgroundColor Red "Error: $($_.Exception)"
      Break
    }
  }
  End {
    If ($?) {
      Write-Host ' '
      Write-Host ' '
    }
  }
}

################
# Start-Script #
################
function Start-Script {
Param ()
Begin {
    Write-Host "Script starting"
    }
Process {
    Try {
        ###########
        #Variables#
        ###########

       Start-Options
        }
        Catch {
      Write-Host -BackgroundColor Red "Error: $($_.Exception)"
      Break
    }
  }
  End {
    If ($?) {
      Write-Host 'User Created Successfully.'
      Write-Host ' '
    }
  }
}

#########################
# RandomDefaultPassword #
#########################
Function RandomDefaultPassword {
Param ()
Begin {
}
Process {
        Try {
            $rand = Get-Random -Maximum 999
            $script:password = 'Welcome=' + $rand
            $script:SecurePassword = $script:password | ConvertTo-SecureString -AsPlainText -Force 
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host ' '
                      Write-Host 'Random Password is:' $script:password
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

########################
# RandomSecurePassword #
########################
Function RandomSecurePassword {
Param ()
Begin {
}
Process {
        Try {
        ################
        # Still to do! #
        ################
            #$rand = Get-Random -Maximum 999
            #$script:password = 'Welcome=' + $rand
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      #Write-Host 'Random Complex Password is:' $script:password
                      Write-Host 'Functionality not implemented yet'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################################################
#                                            OU's#
##################################################

############
# SearchOU #
############
Function SearchOU {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $ou = Read-Host 'What is the name of the Organisational Unit?'
            $sou = "*"+$ou+"*"
            Get-ADOrganizationalUnit -Filter 'name -like $sou' | ft Name,DistinguishedName
            Write-Host ''
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Search Complete.'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

############
# NewOU #
############
Function NewOU {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $newouname = Read-Host 'What is the name of the new Organisational Unit?'
            #$souname = Read-Host 'What is the SAM Name of the OU? [No spaces or special characters]'
            $oupath = Read-Host 'Where is the OU to be created? This should be in Distinguished Name format [OU=X,DC=y,DC=Z]'
            New-ADOrganizationalUnit -Name $newouname -Path $oupath -ProtectedFromAccidentalDeletion:$False
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host $newouname 'has been successfully created.'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

############
# RemoveOU #
############
Function RemoveOU {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $ouname = Read-Host 'What is the Distinguished Name of the Organisational Unit you want to remove? [OU=X,DC=Y,DC=Z]'
            Write-Host '  !!!WARNING!!! ' -ForegroundColor Red -BackgroundColor Black -NoNewline; Write-Host ' This will delete any child objects! ' -NoNewline;Write-Host ' !!!WARNING!!! ' -ForegroundColor Red -BackgroundColor Black -NoNewline
            Remove-ADOrganizationalUnit -Identity $ouname -Confirm:$false
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host $ouname 'has been successfully removed.'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################################################
#                                           Users#
##################################################

##############
# SearchUser #
##############
Function Searchuser {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $user = Read-Host 'What is the Name or Logon of the User?'
            $suser = '*'+$user+'*'
            get-aduser -filter "(name -like '$suser') -Or (SamAccountName -like '$suser')" | ft Title,Name,SamAccountName,DistinguishedName
            Write-Host ''
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Search complete'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

###########
# NewUser #
###########
function NewUser {
Param ()
Begin {
    Write-Host "Creating a new user..."
    }
Process {
    Try {
        ###########
        #Variables#
        ###########
        #Sets the variable for the FQDN
        $domain = $env:USERDNSDOMAIN
        #Sets the variable for the first 3 characters (eg cpt from cpt.test)
        #in a later version, I would like to have it extract the first portion regardless of how many characters it is.
        $domshort = $env:USERDNSDOMAIN.Substring(0,3)
        #Defines the domain DistinguishedName:- dc=domain,dc=com 
        $dn = Get-ADDomain | select -ExpandProperty DistinguishedName 
        #Prompts for User's first and second name, then combines for the Full Name and, at present, the Display name
        $givenname = Read-Host 'What is the users First Name?' 
        $surname = Read-Host 'What is the users Surname?'
        $rank = Read-Host 'What is the users Rank or Title?'
        $fullname = $givenname + ' ' + $surname
        $displayname = $rank + ' ' +$givenname + ' ' + $surname
        #Defines the logon name in the format of surname + first character of first name and a digit value. 
        #In a later version, I want it to check if the user already exists and increment the number
        $suser = $surname+$givenname.substring(0,1)+'100'
        #Defines the logon in UPN format with the FQDN appended to the end
        $upn = $suser + '@' + $domain.ToLower()
        #Defines the logon pre-pended by the domain as per user logon
        $logon = $domshort + '\' + $suser.ToLower()
        #Sets a default password, this could be made user definable if desired rather than a hard coded password.
        #$rand = Get-Random -Maximum 9999 -Minimum 1000
        #$plainpassword = 'Welcome=' + $rand   
        #$script:securepassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force 
        #What OU would the user created in
        $oupath = Read-Host 'What OU is the user to be created in? Format: OU=X,OU=Y,OU=Z,DC=ABC,DC=DEF'
        #$ou = 'OU=Users,OU=Accounts,OU=CPT'
        #$oupath = $ou + ',' + $dn
        #Defines the User Distinguished Name
        
        ###########
        #Variables#
        ###########

        Write-Host ''        
        Write-Host ''
        Write-Host 'First Name:                ' -Foregroundcolor Yellow -nonewline; Write-Host $givenname -foregroundcolor Green
        Write-Host 'Surname:                   ' -ForegroundColor Yellow -NoNewline; Write-Host $surname -ForegroundColor Green
        Write-Host 'Full Name:                 '-Foregroundcolor Yellow -nonewline; Write-Host $fullname -ForegroundColor Green
        Write-Host 'UserPrincipleName:         '-Foregroundcolor Yellow -nonewline; Write-Host $upn -ForegroundColor Green
        Write-Host 'SAM Name:                  '-Foregroundcolor Yellow -nonewline; Write-Host $suser -ForegroundColor Green
        Write-Host 'Password:                  ' -Foregroundcolor Yellow -nonewline; Write-Host $script:Password -ForegroundColor Green
        #Write-Host 'The user must change their password on logon!' -ForegroundColor Magenta
        #Write-Host ''
        #Write-Host 'Logon:              ' -Foregroundcolor Yellow -nonewline; Write-Host $logon -ForegroundColor Green
        #Write-Host ''
        #Write-Host 'Organizational Unit:       ' -ForegroundColor Yellow -NoNewline; Write-Host $oupath -ForegroundColor Green
        #Write-Host ''
     
        New-ADUser -GivenName $givenname -Surname $surname -Name $fullname -DisplayName $displayname -SamAccountName $suser -UserPrincipalName $upn -ChangePasswordAtLogon:$true -AccountPassword $script:SecurePassword -Enabled:$true -Path $oupath
        #Write-Host ''
        $udn = Get-ADUser -Filter 'SamAccountName -eq $suser' | select -ExpandProperty DistinguishedName
        Write-Host 'User Distinguished Name:   ' -ForegroundColor Yellow -NoNewline; Write-Host $udn -ForegroundColor Green
        }
        Catch {
      Write-Host -BackgroundColor Red "Error: $($_.Exception)"
      Break
    }
  }
  End {
    If ($?) {
      Write-Host 'User Created Successfully.'
      Write-Host ' '
      Pause-ForInput
     Start-Options
    }
  }
}

##############
# RemoveUser #
##############
function RemoveUser {
Param ()
Begin {
    Write-Host "Removing a user..."
    }
Process {
    Try {
        ###########
        #Variables#
        ###########
        Write-Host ' Not implemented yet'
        $suser = Read-Host 'What is the username of the user you want to remove?'

        Remove-ADUser -Identity $suser -Confirm:$false
        }
        Catch {
      Write-Host -BackgroundColor Red "Error: $($_.Exception)"
      Break
    }
  }
  End {
    If ($?) {
      Write-Host 'User Removed Successfully.'
      Write-Host ' '
      Pause-ForInput
     Start-Options
    }
  }
}

#############
# SetUserOU #
#############
Function SetUserOU {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $suser = Read-Host 'Enter the users logonname in SAM Account Format'
            $udn = Get-ADUser -Filter 'SamAccountName -eq $suser' | select -ExpandProperty DistinguishedName
            $targetou = Read-Host 'Enter the desired OU in Destinguished Name format (OU=A,DC=B,DC=C)'

            Move-ADObject -Identity $udn -TargetPath $targetou
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'User moved successfully'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################
# AddUserToGroup #
##################
Function AddUserToGroup {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $suser = Read-Host 'Enter the users logonname in SAM Account Format'
            $secgroup = Read-Host 'Enter the Security Group to add the user to'

            Add-ADGroupMember -Identity $secgroup -Members $suser
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host $suser 'added to' $secgroup 'successfully'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

#######################
# RemoveUserFromGroup #
#######################
Function RemoveUserFromGroup {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $suser = Read-Host 'Enter the users logon name in SAM Account Format'
            $secgroup = Read-Host 'Enter the Security Group to remove the user from'

            Remove-ADGroupMember -Identity $secgroup -Members $suser -Confirm:$false
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host $suser 'removed from' $secgroup 'successfully'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##############
# EnableUser #
##############
Function EnableUser {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $suser = Read-Host 'Enter the users logon name in SAM Account Format'
            
            Set-ADUser -Identity $suser -Enabled:$true
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host $suser 'enabled successfully'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

###############
# DisableUser #
###############
Function DisableUser {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $suser = Read-Host 'Enter the users logon name in SAM Account Format'
            
            Set-ADUser -Identity $suser -Enabled:$false
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host $suser 'disabled successfully'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

#############
# SetUserPW #
#############
Function ResetUserPW {
Param (
        [String]$script:suser = $(Write-Host 'Enter the logon for the user you want to set a password for: ' -foregroundcolor Yellow -NoNewLine; Read-Host),
        $temppass = $(Write-Host 'Enter the desired temporary password: ' -Foregroundcolor Yellow; Read-Host -AsSecureString)
)
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            #Write-Host 'Enter the logon for the user you want to set a password for.' -f
            #$user = Read-Host "Enter the Logon for the user you want to set a password for"
            $udn = Get-ADUser -Filter 'SamAccountName -eq $suser' | select -ExpandProperty DistinguishedName
            #$temppass = Read-Host 'Enter the desired temporary password'

            Set-ADAccountPassword -Identity $script:suser -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $temppass -Force)
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Password sucessfully changed for user'$user -ForegroundColor Green
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

######################
# CheckUserLockedout #
######################
Function CheckUserLockedOut {
Param (
        [String]$script:suser = $(Write-Host 'Enter the logon for the user you want to check: ' -foregroundcolor Yellow -NoNewLine; Read-Host)
        
)
Begin {
}
Process {
        Try {
            $lockedoutresult = 'blank'
            $lockedoutuser = (Get-Aduser $script:suser -Properties LockedOut).LockedOut
            $enableduser = (Get-Aduser $script:suser -Properties Enabled).Enabled
            if ( $lockedoutuser -eq $true) { $lockedoutresult = 'is locked out.' }
            elseif (($lockedoutuser -eq $true) -and ($enableduser -eq $false )) { $lockedoutresult = 'is locked out and is disabled.' }
            elseif (($lockedoutuser -eq $true) -and ($enableduser -eq $true )) { $lockedoutresult = 'is locked out.' }
            elseif (($lockedoutuser -eq $false) -and ($enableduser -eq $false )) { $lockedoutresult = 'is not locked out but is disabled.' }
            elseif (($lockedoutuser -eq $false) -and ($enableduser -eq $true )) { $lockedoutresult = 'is not locked out.' }
            else {Write-Host 'How on earth did you get this result?!' }
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host $script:suser -ForegroundColor Green $lockedoutresult
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##############
# UnlockUser #
##############
Function UnlockUser {
Param (
        [String]$script:suser = $(Write-Host 'Enter the logon for the user you want to check: ' -foregroundcolor Yellow -NoNewLine; Read-Host)
        
)
Begin {
}
Process {
        Try {
            $lockedoutresult = 'blank'
            $lockedoutuser = (Get-Aduser $script:suser -Properties LockedOut).LockedOut
            #$enableduser = (Get-Aduser $script:suser -Properties Enabled).Enabled
            if ( $lockedoutuser -eq $true) {Unlock-ADAccount -Identity $script:suser 
            $lockedoutresult = 'is now unlocked' }
            elseif ($lockedoutuser -eq $false) 
            {$lockedoutresult = 'is not locked out.'}
            elseif ($lockedoutuser -eq $true) 
            {$lockedoutresult = 'is locked out.'}
            else {Write-Host 'How on earth did you get this result?!'}
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
            }
        End {
            If ($?) {
                      Write-Host $script:suser -ForegroundColor Green $lockedoutresult
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################################################
#                                       Computers#
##################################################

###################
# Search Computer #
###################
Function SearchComputer {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $computer = Read-Host 'What is the name of the Computer?'
            $searchedcomputer = '*'+$computer+'*'
            Get-ADComputer -Filter 'ObjectClass -eq "Computer"' | Where-Object name -Like $searchedcomputer | ft Name,DistinguishedName
            Write-Host ''
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Search complete'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

#######################################
# Set A Computers Organisational Unit #
#######################################
Function SetComputerOU {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $computername = Read-Host 'Enter the Name or partial name of the computer you want to move to a new OU'
            $udn = Get-ADUser -Filter 'SamAccountName -eq $suser' | select -ExpandProperty DistinguishedName
            $targetou = Read-Host 'Enter the desired OU in Destinguished Name format (OU=A,DC=B,DC=C)'

            Move-ADObject -Identity $udn -TargetPath $targetou
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'User moved successfully'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################
# EnableComputer #
##################
Function EnableComputer {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Function to be removed'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

###################
# DisableComputer #
###################
Function DisableComputer {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host Write-Host 'Function to be removed'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################################################
#                                          Groups#
##################################################

##################
# SearchSecGroup #
##################
Function SearchSecGroup {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $group = Read-Host 'What is the name of the Security Group?'
            $sgroup = "*"+$group+"*"
            Get-ADGroup -Filter {(groupcategory -eq 'Security') -and (name -like $sgroup)} | ft Name,DistinguishedName,SamAccountName
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      #Write-Host 'Function not yet implemented'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################
# NewSecGroup #
##################
Function NewSecGroup {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            
            $newgroupname = Read-Host 'What is the name of the new Security Group?'
            #$souname = Read-Host 'What is the SAM Name of the OU? [No spaces or special characters]'
            $grouppath = Read-Host 'Where is the OU to be created? This should be in Distinguished Name format [OU=X,DC=y,DC=Z]'
            $groupdescription = Read-Host 'What is the description of the OU to be?'
            New-ADGroup -Name $newgroupname -SamAccountName $newgroupname -GroupCategory Security -GroupScope Global -DisplayName $newgroupname -Path $grouppath -Description $groupdescription
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      #Write-Host 'Function not yet implemented'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################
# RemoveSecGroup #
##################
Function RemoveSecGroup {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            $groupname = Read-Host 'What is the name of the Security Group you want to remove?'
            Remove-ADGroup -Identity $groupname -Confirm:$false
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      #Write-Host 'Function not yet implemented'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##################
# ListUserSecGroup #
##################
Function ListUserSecGroup {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Function not yet implemented'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

#####################
# AddUserToSecGroup #
#####################
Function AddUserToSecGroup {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Function not yet implemented'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}

##########################
# RemoveUserFromSecGroup #
##########################
Function RemoveUserFromSecGroup {
Param ()
Begin {
}
Process {
        Try {
            ###########
            #Variables#
            ###########
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Function not yet implemented'
                      Write-Host ' '
                      Pause-ForInput
                      Start-Options
                    }
        }
}



##################################################
#                                          Script#
##################################################

############
# Menu GUI #
############
Function Start-Menu {
Param (
        [String]$userinput = $(Write-Host 'Select an Option: ' -foregroundcolor Yellow -NoNewLine; Read-Host)
)
Begin {
}
Process {
        Try {
            Switch ( $userinput )
                {
                0 { RandomDefaultPassword }
                1 { RandomSecurePassword }
                2 { SearchOU }
                3 { NewOU }
                4 { RemoveOU }
                5 { SearchUser }
                6 { NewUser }
                7 { RemoveUser }
                8 { SetUserOU }
                9 { AddUserToGroup }
                10 { RemoveUserFromGroup }
                11 { EnableUser }
                12 { DisableUser }
                13 { ResetUserPW }
                14 { CheckUserLockedOut }
                15 { UnlockUser }
                16 { SearchComputer }
                17 { SetComputerOU }
                18 { EnableComputer }
                19 { DisableComputer }
                20 { SearchSecGroup }
                21 { NewSecGroup }
                22 { RemoveSecGroup }
                23 { ListUserSecGroup }
                24 { AddUserToSecGroup }
                25 { RemoveUserFromSecGroup }
                26 { Exit }
                27 { test-password }
                }
                Start-Menu
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Password sucessfully changed for user'$user -ForegroundColor Green
                      Write-Host ' '
                    }
        }
}

################
# Menu Options #
################
Function Start-Options {
Param (

)
Begin {
}
Process {
        Try {
            Clear-Host
            Write-Host ' '
            Write-Host ' '
            Write-Host '                 ' -NoNewLine; Write-Host ' [' -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host 'Active Directory Manamgenent Tasks'  -ForegroundColor Black -BackgroundColor White -NoNewline; Write-Host '] ' -ForegroundColor Red -BackgroundColor White
            Write-Host '                 ' -NoNewLine; Write-Host ' [' -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host '          Version 1.0.4           '  -ForegroundColor Black -BackgroundColor White -NoNewline; Write-Host '] ' -ForegroundColor Red -BackgroundColor White
            Write-Host ' '
            Write-Host '      ' -NoNewLine; Write-Host ' [' -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host '  Misc '  -ForegroundColor Black -BackgroundColor White -NoNewline; Write-Host '] ' -ForegroundColor Red -BackgroundColor White
            Write-Host '  0 - Generate a random Default Password '
            Write-Host '  1 - Generate a random Secure Password '
            Write-Host ' '
            Write-Host '      ' -NoNewLine; Write-Host ' [' -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host '  Organisational Units (OU)  '  -ForegroundColor Black -BackgroundColor White -NoNewline; Write-Host '] ' -ForegroundColor Red -BackgroundColor White
            Write-Host ' '
            Write-Host '  2 - Search OU'
            Write-Host '  3 - Create OU'
            Write-Host '  4 - Remove OU'
            Write-Host ' '
            Write-Host '      ' -NoNewLine; Write-Host ' [' -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host '  Users  '  -ForegroundColor Black -BackgroundColor White -NoNewline; Write-Host '] ' -ForegroundColor Red -BackgroundColor White
            Write-Host '  5 - Search for a User'
            Write-Host '  6 - Add a User'
            Write-Host '  7 - Remove a User'
            Write-Host '  8 - Set User OU'
            Write-Host '  9 - Add User to group'
            Write-Host ' 10 - Remove User from group'
            Write-Host ' 11 - Enable User'
            Write-Host ' 12 - Disable User'
            Write-Host ' 13 - Reset User password'
            Write-Host ' 14 - Check is User locked out'
            Write-Host ' 15 - Unlock User account '
            Write-Host ' '
            Write-Host '      ' -NoNewLine; Write-Host ' [' -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host '  Computers  '  -ForegroundColor Black -BackgroundColor White -NoNewline; Write-Host '] ' -ForegroundColor Red -BackgroundColor White
            Write-Host ' 16 - Search for a Computer '
            Write-Host ' 17 - Set Computer OU'
            Write-Host ' 18 - Enable Computer [DISABLED]'
            Write-Host ' 19 - Disable Computer [DISABLED]'
            Write-Host ' '
            Write-Host '      ' -NoNewLine; Write-Host ' [' -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host '  Groups  '  -ForegroundColor Black -BackgroundColor White -NoNewline; Write-Host '] ' -ForegroundColor Red -BackgroundColor White
            Write-Host ' 20 - Search Security Groups'
            Write-Host ' 21 - Create a Security Group'
            Write-Host ' 22 - Remove a Security Group'
            Write-Host ' 23 - List Users in a Security Group '
            Write-Host ' 24 - Add User to a Security Group '
            Write-Host ' 25 - Remove User from a Security Group '
            Write-Host ' '
            Write-Host ' 26 - Exit Script'
            Write-Host ' '
            Start-Menu
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Password sucessfully changed for user'$user -ForegroundColor Green
                      Write-Host ' '
                    }
        }
}

###############
# Exit Script #
###############
Function Exit-Script {
Param (

)
Begin {
}
Process {
        Try {
            exit
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            Break
            }
        }
        End {
            If ($?) {
                      Write-Host 'Password sucessfully changed for user'$user -ForegroundColor Green
                      Write-Host ' '
                    }
        }
}

###################
# Pause for input #
###################
Function Pause-ForInput {
Param (
        
)
Begin {
}
Process {
        Try {
            [String]$pauseforinput = $(Write-Host 'Press '-NoNewLine; Write-Host '[ENTER]' -ForegroundColor Yellow -NoNewline; Write-Host ' to continue...'; Read-Host)
            }
            Catch {
            Write-Host -BackgroundColor Red "Error: $($_.Exception)"
            }
        }
        End {
            If ($?) {
                      Write-Host 'Password sucessfully changed for user'$user -ForegroundColor Green
                      Write-Host ' '
                    }
        }
}


#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Script Execution goes here

#NewUser
#RandomDefaultPassword
#SetUserOU
#searchou
#searchcomputer
#searchuser
#SetUserPW


Start-Script
            
## TO DO
##
## > ListChildOU
## > ListChildObject

## > ListSecGroupMembers
## > AddUserToSecGroup
## > RemoveUserFromSecGroup

## > Generate Complex Password

## Future Build intentions:
##
## > Add error checking to functions
