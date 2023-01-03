# ACTIVE-DIRECTORY---HOME-LAB

Comprehensive Active Directory Home Lab


Lab Overview

This is a detailed step by step guide on how to create your own Active Directory home lab using Virtual Box. You will learn how to setup a test network consisting of one domain controller (Server 2019) and two client machines (Windows 10). This setup will reflect a typical corporate network by placing all client machines on an internal private network. All traffic to and from the internal network will be routed through the domain controller. This prevents the client machines from being exposed directly to the external internet. You will use Network Address translation to allow the client machines to access the internet through the domain controller. 

This setup gives the organization control over all users and client machines on the network. This makes managing access and permissions on the network much easier.

Once the test network is setup, you will then learn how to setup Active Directory and create Organizational Units. This will allow you to configure permissions and group policies for different Organizational Units and security groups.

You will also learn common active directory tasks such as creating new users, disabling users, and resetting passwords. You also learn to configured common group policy tasks such as mapping network drives, pre-installing required software onto machines, and enforcing custom wallpaper for each department.

Additional skills you will learn is how to remotely login into client machines using RDP and Remote Assistance to help with troubleshooting their system.

Test Network Layout
 

Test Network Setup
The first step in setting up your test network is to download and install Virtual Box. It is a type 2 hypervisor which you will use to create virtual machines that will function as your servers and client machines. 
1.	Download virtual box here: 
https://www.virtualbox.org/wiki/Downloads
2.	Click the version that corresponds to your operating system.
 
3.	Also download Oracle VM Virtual Box Extension Pack and store it in the same location.
 

You will also need to download the right operating systems which you will install onto the virtual machines. You will use Server 2019 for the domain controller and Windows 10 Enterprise for the client machines.
1.	Download the O.S evaluation images here:
https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2019
https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise
2.	Choose ISO format. 
 
3.	Then fill out personal info to get to the download link. You can fill the form with bogus personal info if you don’t want to enter your real personal info.
 

Create Domain Controller VM
Now that you have VirtualBox installed and downloaded the right operating systems, its time to create your first virtual machine. This will be the domain controller.
1.	Open VirtualBox and click the new button to start the process.
 
2.	Name your virtual machine and select the location to store it. For O.S choose Microsoft Windows and “Other Windows” For the version. Then click next.
 
3.	Give your virtual machine a minimum of 2GB of ram. You can increase this number later if your virtual machine is too slow. Then click next.
 
4.	Select “Create virtual hard disk now”. Then click next.
 
5.	Choose VMDK as hard disk file type. VDI is typically used but I plan on uploading a snapshot of my VM onto GitHub. Therefor I choose VMDK because it will also work on other popular virtualization software like VMware. This will make it accessible to the largest number of people who want to use it.
 
6.	Leave the remaining settings at default. Click through to the end to finish creating the VM.

Configure Domain Controller VM and Network Adapters
Now that the VM for the domain controller is created. Let’s configure the settings before you launch it.
1.	Click on the newly created VM and select the settings button.
 
2.	Under General -> Advanced. Change “Shared Clipboard” and “Drag’n’Drop” to Bidirectional. This will allow you to use copy and paste between your personal computer and the VM.
 
3.	Next, you will configure the external and internal network adapters on the VM. Go to Network -> Adapter 1. Change “Attached to” to NAT. This will allow the VM to connect to your home internet and get an IP address.
 
4.	Click on “Adapter 2” and change “Attached to” to Internal Network. This will allow the domain controller to connect to the internal private network that the client computers will sit on.
 

Install Server 2019
The VM for the domain controller is now configured. You can now begin the process of installing Server 2019 onto the VM. 
1.	Double click the VM to launch it.
 
2.	You will be prompted to add the disk image of the O.S you want to use. Navigate to the location where you saved it and select it. Then click start to start the VM.
 
You Can also add the disk by going to Devices -> Optical Drives -> Choose disk file.
 
	You will need to reset the VM after adding the disk this way.
 
3.	Now you will go through the standard windows installation.
 
4.	Choose Standard Evaluation (Desktop Experience). Click next.
 
5.	Choose custom install. Click next.
 
6.	It will prompt you to create password. Choose something you will remember.
7.	It will take a long time to install but eventually you will get to welcome screen. You will need to go to Input -> keyboard -> Insert Ctrl-Alt-Del to bring up the logon page.
 
8.	After you logon. The VM will be very slow and lag a lot. The first thing you should do is go to Devices -> Insert Guest Additions CD image.
 
9.	Then open file explorer and go to This PC. Double click on Virtual Guest Additions drive.
 
10.	Double click and install “VBoxWindowsAdditions-amd64”. Then restart the VM. This will improve the performance and make the VM run smoother and reduce the lag.
 
11.	The next step is to now rename our server. This will give it a more human readable name that you can easily reference later. To change the name, go to settings -> about -> rename this pc.
 

Configure Server Network Adapters
With the installation complete. you can now setup the network connections for the server.
1.	Go to Control panel\ Network and Internet\ Network Connections.
 
2.	Right click on the connections and click status. 
 
3.	Then click on details.
 
4.	Do this to both adapters and find the one with an IP of 169.254.XXX.XX. This is the one that has an auto configured IP. 
 
5.	When you find this one. You will go back and right click on it and select Rename. Change the name to ‘Internal’. Then change the name of the other adapter to “External”. This will help you differentiate them later when configuring NAT.
 
6.	With the adapter names properly changed, you can now configure the IP for the internal adapter. Go back to the internal network adapter and right click and select properties.
 
7.	 Double click on internet protocol Version 4
 
8.	Click “use the following IP address”. Change the IP to the following below. The internal network is private so you will assign an IP address in the private address range. The default gateway will be blank since the domain controller will be the default gateway/router. You will also set the DNS server IP address to be the same as the domain controller server so that it can later be its own DNS server. You can then click ok to save the settings.
 

Install Active Directory 
You are now ready to install Active Directory on your server. 
1.	Start by opening Server Manager and selecting Manage -> Add Roles and Features.
 
2.	Stick with the default choices and select next until you get to the page below. Click the box for “active directory domain services”. You can then continue to click next to the end.
 
3.	That installation will take a while. Once it’s done, you will see a flag at the top of Server Manager. Click on it to open the drop down and click “Promote this server to a domain controller”. You have installed the services for active directory, but you still need to now configure it.
 
4.	Click Add a new forest and name your domain. Then click next.
 
5.	You will now create a password for your domain controller restore mode. Then click next to the end. You will need to then restart the computer and log back in.
 
6.	Now that Active Directory is installed, you don’t have to keep using the default built in account. You can now create a local administrator account that you can use to logon with going forward. To do that you can first create an Organizational Unit to store the admin accounts. You do this by opening “Active Directory Users and Computers. This can also be found under tools in the server manager.
 
7.	Right click the domain name and select New -> Organizational Unit.
 
8.	Give the Organizational Unit (OU) a name starting with an underscore (_) so that it will show up at the top of the list of Organizational Units.
 
9.	Then right click on that newly created OU and go New -> User.
 
10.	 Give the account a name and username you like.
 
11.	Then create a password that you will remember. Uncheck user must change password and check password never expires.
 
12.	You’ve now created your account but it’s still just a standard user. To make it an administrator; right click on it and select properties.
 
13.	Click on the “Member Of”. Then select Add.
 
14.	Type in “Domain Admins” then click Check Names to make sure its correct. Then hit Apply. You can now log off and then log back in with your newly created account.
 
15.	When logging on. Select other user and then enter the username and password for the new account.
 

Configure NAT/RAS
With Active Directory configured. You can now turn your sights to configuring the internal network for the client machines.
1.	In Server Manager, click Manage -> Add Roles and Features.
 
2.	Click next until you get to the page below. Check the box for “Remote Access”.
 
3.	Then on the next page, check the “Routing” box. Then click next to the end to finish installing the features.
 
4.	Once the installation is complete. Go to Server Manager and select Tools -> Routing and Remote Access.
 
5.	Right click on the domain controller server and select “Configure and Enable Routing and Remote Access”.
6.	Select Network address translation. Then click next.
 
7.	Select “Use this public interface to connect to the internet”. Then select the internet adapter that you named external or internet. Then click through to the end and finish the installation.

Configure DHCP
Next step is to configure our domain controller to also serve as a DHCP server. This will allow the client machines on the internal private network to dynamically receive IP addresses when they join the network.
1.	In Server Manager. Click Add Roles and Features.
 
2.	Click next until you get to the page below. Check the box for “DHCP Server”. Then click next to the end.
 
3.	After the installation, you can now configure DHCP by going to Tools -> DHCP.
 
4.	Right click on IPV4 and select New Scope.
 
5.	Enter the following IP ranges and subnet masks of addresses that the server can give out. Then click next until you get to the next page.
 
6.	Click Yes. I want to configure these options now. Click next until you get to the next page.
 
7.	Now enter the IP address of the domain controller server. This will allow it to function as a router and be the default gateway for the internal network. Then click next.
 
8.	 Click Yes, I want to activate this scope now.
 
9.	Now that you have installed and configured DHCP, right click on Server Options and select Configure Options. Make sure that Router is selected as an option. Also check that the IP address is the same as the domain controller server.
 
10.	Once that is confirmed, you can right click on the server name and select Authorize.
 
11.	Then you can right click on the server and select Refresh to update it. Now there should be a green check mark next to the IPV4 option.
 
Now the clients on the internal network will be able to receive an IP address when they connect to the network and be able to access the internet.

Import 100 users Using PowerShell
To make your lab more realistic, you will import 100 users into active directory so that you can practice placing them in different Organizational Units and applying unique group policies. To make that process easier, you will write a PowerShell script to import a list of 100 users. The names of these users will be randomly generated and saved to a .txt file.
1.	First use a random name generator website to generate 100 unique names. Copy those names and save in a .txt file.
The names I used are generated from this site:
https://randomwordgenerator.com/name.php
2.	Next create a PowerShell script to create a new Organizational Unit named “_Imported Users”. Then import the 100 names into that Organizational Unit from the .txt file. For each user, you must also create a username and require them to change their password on first logon.
3.	The script that I created and used is available on GitHub for reference:
https://github.com/YMahabeer/ACTIVE-DIRECTORY---HOME-LAB/blob/77e2fdfc1bbb7967c99a8c79c8b668eca56590af/Import%20Users%20From%20txt%20-%20Public.ps1
To allow the script to execute, you will also need to run the command: 
Set-ExecutionPolicy Unrestricted
Also use PowerShell ISE with admin privileges to run the script. This will allow you to paste your script into it and then press run (green triangle) to execute it.
 

Create Client Machines
The last major step is to create the client machines that will live on the private internal network. The process is very similar to setting up the domain controller server so I will go through this more quickly and highlight the steps that are different.
1.	In VirtualBox. Press the New button and create the VM that your client will run on. The version will be Windows 10. Give the VM atleast 4GB ram.
 
2.	After creating the VM. Right click on it and go to settings. Go to General -> Advanced. Change shared clipboard and the Drag’n’ drop settings to Bidirectional.
 
3.	Also, in the settings pane. Go to Network -> Adapter 1. Change “Attached to” to Internal network.
 
4.	Now you can launch the VM and load the Windows 10 Enterprise disk to begin installation. If asked to create a Microsoft account; Look for alternate options like “setup without internet” or “Join a domain instead”. Follow the standard installation process then proceed to the next step.
5.	After installation, the first thing to do is install “VBoxWindowsAdditions-amd64” so that the VM can run better. You do this by going to Devices -> Insert Guest Additions CD image.
 
6.	Then open file explorer and go to This PC. Double click on Virtual Guest Additions drive.
 
7.	Double click and install “VBoxWindowsAdditions-amd64”. Then restart the VM.
 
8.	After those steps, you will need to make sure that our client machine can connect to the internet. Open PowerShell and enter the Ipconfig command to make sure you are connected to the internal private network and can also reach the internet. You can also ping a known site like google using the command “ping google.com”
 

Join Client to Domain
The client OS installation is complete and is now connected to the network. You can now move on to joining it to the domain you created earlier.
1.	The first step is to give our client a more human readable name. To change the name, go to Settings -> About -> Rename this PC (advanced).
 
2.	Click on Change.
 
3.	Give your computer a new name. Also click “member of domain:”.  Enter the name of the domain you created. Then click next. You will be prompted to enter the credentials of an account that is already on that domain. That is used to verify that you have permission to join that domain.
 
4.	If successful, you will see something similar to this below.
 
5.	You can confirm that the client has joined the domain by going back to the domain controller and going to the DHCP tool in Server Manager. Under address leases, you should see the client machine there.
 
6.	Also in active directory, if you look in the computers folder. You should see the client there also.
 

Clone VM
Your first client computer is now configured. You can do the same exact steps to also create the second client computer on your virtual network. You can also make the process of creating more virtual machines easier by creating a clone of the first client machine.

1.	To create a clone of a VM in VirtualBox. Make sure the VM is powered off first. Then right click on the VM and select Clone.
 
2.	Give the clone a unique name. Then choose the location to save the new VM.  For Mac Address Policy, change the drop-down menu to Generate new MAC addresses for all network adapters. Then click Next.
 
3.	Choose full clone. Then click the Clone button.
 
4.	This progress screen will pop-up and it might take a while to create a clone of your machine.
 
5.	Once the cloning process is done. You will now have another VM in VirtualBox that you can deploy and configure as Client2.

6.	To configure this new VM. You will have to power it on and first change its name. To change the name, go to Settings -> About -> Rename this PC (advanced).
 
7.	Click on Change.
 
8.	Give your machine a new name. You will also have to re-authorize the machine to be on the domain. You do this by first removing it from the domain. Change “Member of” to Workgroup and give it a name of WORKGROUP. Then click ok and restart the machine.
 
9.	Now you can go back and re-add this machine to the domain. You will be prompted to authenticate using the username and password of a user account that is on the domain. Then restart the machine to apply the changes.
 
10.	You should now see this new machine show up in Active Directory Users and Computers. Look in the Computers folder to see the new machine.
 

Common Active Directory Tasks to Learn
Let’s do a few common tasks that are performed using Active Directory.
1.	Finding users
You will need to find a user in Active Directory before you can make any changes to their account. You can search manually for a user by going through the Organizational Units and finding where their account is located. A better way is to use the “Find” feature which allows you to search using keywords.

To use the Find feature; right click on the domain or any Organizational Unit. Then select Find.
 
You can now enter the name of the user and it will return user accounts that contain those search terms you entered. Double click on the desired user to open their account.
 
You can modify what you search for using the “find” dropdown menu. The “In” drop down menu can also be used to select what location and O.U you want to search in.
 

2.	Unlock accounts.
If a user tries too many times to logon to their account unsuccessfully, they will be locked out. To unlock a user’s account; double click on their name to open their user properties. Go to the account tab. Check the Unlock account box. Then hit apply.
 

3.	Reset passwords
To reset the password on a user’s account; right click on their name and click on Reset Password.
 
You can now enter a new default password for them. Make sure “user must change password at next logon” is selected. You should also check “unlock the users account” to make sure its unlocked if the user tried too many times to logon. Then hit apply.
 

4.	Disable accounts
When a user leaves the organization or has their machine compromised, you will need to disable their account. To do so, right click on their user profile and select Reset Password.
 

5.	Create and structure Organizational Units
Having the structure of your Organizational Units setup properly will make a huge difference in how difficult it is to manage user permissions and configure group policy. It’s best to structure your Organizational Units to reflect the physical structure of the organization. You will also want your structure to be as simple and minimal as possible. Too many Organizational Units will make it difficult and confusing to manage.

Let’s go through how to setup a typical Organizational Unit tree from scratch. First, you will right click on the domain and select new -> Organizational Unit. 
 
This new O.U will be the parent container that represents the overall business organization. Its best to also add an underscore in front of the name (ex: _Production). This will make it appear at the top of the list of Organizational Units in the domain structure.  
 
Next, you will create Organizational Units that represent different physical locations of the business. Within those locations you can then create further sub-divisions for each floor or section of each location. 
 
Within those physical divisions, you can then create Organizational Units that represent different departments on each floor. Within each department, you can then create a final Organizational Unit for the managers of those departments.
If your organization is only in one location or just has one floor, you can skip those layers and only add the subdivisions that make sense for your organization. 
 
You can now drag the users into the appropriate Organizational Units to finalize the structure of your organization. You can also right click on a user and select Move. 
  
Now you can select which O.U to move that user into.
 

6.	Configure and update group policy
Now that you have setup the structure of your Organizational Units and added the right users to them, you can now configure group polices.

a.	Custom wallpaper 
The classic group policy example is to enforce a custom wallpaper for an entire department. You will do this for the I.T department. To do this, go to the Group Policy Management tool.
 
Right click on the Organizational Unit that you want to add a policy to. Then select “Create a GPO in this domain, and Link it here…”.
 
Give it a name that will make it easy to understand what this policy is doing. 
 
The new Group Policy Object (GPO) will appear under the Organizational Unit it is created for. To customize the GPO, right click the GPO and select Edit. 
 
This will bring up the Group Policy Management Editor. Navigate to the policy that you want to make changes to. To change the wallpaper, navigate through the folders on the left and go to User Configuration -> Administrative Templates -> Desktop -> Desktop. Then on the right. Double click on Desktop Wallpaper.
 
You can now select the Enabled radio button on the upper left. This will now allow you to enter the path to the image that you want to use for the wallpaper. Also change the wallpaper style to Fill. Then hit apply. The next time a user in the I.T Organizational Unit logs in, they will see the new wallpaper.
 
For this lab, you can use one of Microsoft’s built-in wallpapers. They are located here: C:\Windows\Web\Wallpaper.

Its best to place the wallpaper image in a shared folder. This will allow any computer on the network to reference the image file.

To create a shared folder; right click in the desired location and select New -> Folder.
 
Name that folder IT Wallpaper. Then right click on it and select Properties.
 
Click on the Sharing tab then click on the Advanced Sharing button.
 
Check the Share this folder box. Give the share a name. Then click on the Permissions button.
 
Make sure that the only permission for everyone is Read. Then click ok. Then hit Apply.
 
You will now go back to the sharing tab for the folder. You can now copy the network path and paste it into the GPO path. 
 
You will also need to append the wallpapers image name to the shared folder path.
 
You can also make sure only users that are part of the domain can access this shared folder. Right click on the shared folder and go to properties. Then go to the security tab. Click the edit button.
 
Then click on Add.
 
Type in Authenticated Users the click Check Names.
 
You can now click ok to apply the changes.
You will leave this group with the default permissions. Click apply to finalize the changes.
 

b.	Install google chrome on all user machines in a department.
It’s common to pre-install certain software onto client computers. This allows the organization to have pre-approved software installed on client machines. 
In this example, you will install Google Chrome on all client machines in the sales department. 

You will first have to download the .msi version of Google Chrome. The .exe version will not work. You can also use 3rd party software to convert .exe files to .msi.

To get the .msi version, you will have to download the enterprise version of Google Chrome. You can find it by searching on Google for “google chrome for enterprise msi”. The direct link to it is here: https://chromeenterprise.google/browser/download/

After you download Chrome Enterprise, you will need to create a new OU that will contain the machines that you want Chrome to be installed on. This is because all new machines are added under the Computers folder by default. This is a folder and not an OU so you are not able to create a GPO that will be able to target that folder. Its best practice is to create this OU of machines next to the OU that contains those Users. It will look similar to the example below.
 
After creating the OU for the machines, drag the desired machines from the Computers folder into this new OU.
 
You will also need to create a shared folder to store the Chrome installation file while still making it accessible to other computers on the network. To create a shared folder, right click in the desired location and select New -> Folder.
 
Name that folder “IT Dept Chrome Install”. Then right click on it and select Properties.
 
Click on the Sharing Tab then click on the Advanced Sharing button.
 
Check the Share this folder box. Give the share a name. Then click on the Permissions button.
 
Make sure that the only permission for everyone is Read. Then click ok. Then hit apply.
 
You can also make sure only users that are part of the domain can access this shared folder. Right click on the shared folder and go to Properties. Then go to the Security tab. Click the edit button.
 
Then click on add.
 
Type in Authenticated Users the click Check Names.
 
You can now click ok to apply the changes.
You will leave this group with the default permissions. Click apply to finalize the changes.
 
To get the link to the shared folder. Right click on it and select Properties. Under the Sharing tab, you will see the network path. You will also have to append the name of the installation file to the end of this path. EX: \\DCSERVER\IT Dept Installs\Chrome\GoogleChromeStandaloneEnterprise64.msi
 
Now you are ready to create the GPO. Go to Server Manager and open the Group Policy Manager tool.
 
Right click on the Organizational Unit that you want to add a policy to. Then select “Create a GPO in this domain, and Link it here…”.
 
Give it a name that will make it easy to understand what this policy is doing. 
 
The new Group Policy Object (GPO) will appear under the Organizational unit it is created for. To customize the GPO, right click the GPO and select Edit. 
 
This will bring up the Group Policy Management editor. Navigate to the policy that you want to make changes to. To add our entry. Go to Computer Configuration -> Policies -> Software Settings -> Software installation. Right click on Software installation and select Properties.
 
You can now paste the location of the shared folder (the folder but not the installation file path) under Default package location. Then click apply. Then ok.
 
Now right click again on Software installation and select New -> Package. 
 
This will open the location of the shared folder that you provided earlier. You can then navigate to and click on the installation file and select open.
 
Then select Assigned and click ok.
 
You will now see Google Chrome show up in the panel.
 
Now the next time the user logs into that client computer they will have Google Chrome installed. If you don’t see Chrome installed on the client machine then you might have to wait a few minutes for it to finish installing. You can also execute the command gpupdate /force to update the group policy on that machine. Then restart that machine again to see if Chrome has been installed. 

c.	Map network drive using group policies.
Having one common drive which only users in a single department can access is a common scenario. This is useful as a central repository where everyone in that department can store and find files to get their job done. 

To map a network drive; you will first have to create a security group which will contain a list of all users which can access this network drive. Create the security group by going to Active Directory Users and Computers. Right click in the OU that you want to create the new security group inside. Select New -> Group.
 
Give the Group a name and select ok.
 
You can now add members to this security group. Select the users you want to add then right click and select Add to a group.
 
Then enter the name of the group and clicking Check Names to confirm the group name. Then selecting ok to add those users to the group.
 
You can confirm these users are in the group by right clicking on the security group and selecting Properties. Then navigate to the Members tab to confirm they are listed there. You can add additional users by selecting Add. Now you can search and add more users to the group if needed.
 
You will need to also create a shared folder which will become our mapped drive. You do this by right clicking where you want this shared folder to be and selecting New -> Folder. 
 
Give it a name then right click and select Properties.
 
Go to the Sharing tab and select Advanced Sharing.
 
Then check the Share this folder box. Also give the share a name. Now click the Permissions button.
 
Click the Add button.
 
Type in Authenticated Users then click the Check Names button to confirm. Then select ok and apply.
 
Make sure the permissions for Authenticated Users are set to Change and Read. Now select ok and then apply. 
 
You can also make sure only users that are part of the domain can access this shared folder. Right click on the shared folder and go to Properties. Then go to the Security tab. Click the Edit button.
 
Then click on Add.
 
Type in Authenticated users then click Check Names. You can now click ok to apply the changes.
 
You will leave this group with the following permissions. Click apply to finalize the changes.
 
Take note of the path of the shared folder for later.  
You can now move onto creating the GPO. Go to Server Manager and open the Group Policy Management tool.
 
You will now create the GPO in the OU that contains your Security Group. Right click on that OU and select “Create GPO in this domain and link it here”. 
 
Give the GPO a name that makes sense. Then select ok.
 
Now right click on the GPO and select Edit.
 
This will open the Group Policy Management Editor. Navigate to User Configuration -> Preferences -> Drive Maps. Right click on Drive Maps and select New -> Mapped Drive.
 
Change Action to Create. Then add the path for the shared folder that you created earlier. Add the name of the drive under Label as.  Then check the Use radio control and select your desired drive letter.
 
Next select the Common tab. Check the Run in logged-on users security context and Item level targeting box. Then click the Targeting box.
 
Now select on New Item then Security Group.  This will allow you to specify that you only want users in a certain security group to have access to this drive.
 
Select the button with three dots on the right to find the specific security group.
 
Enter the name of the group and then select Check Names to confirm the name. Then select ok.
 
You will now see the conditions update. Now select ok, apply then ok again to apply changes.
 
Now your changes should be seen in Group Policy Management Editor.
 
Now you can test the new drive by logging in as a user in the specified security group. If the drive does not show-up then you can enter the command “gpupdate /force” then restart the machine.
You will also want to test that users in that security group have access to write and read to that drive. Also make sure that other users outside of that security group can’t access this drive.

Other Common Tasks
Other tasks include ways to remotely troubleshoot a client machine.
1.	Remotely logging into machines using Remote Desktop Protocol (RDP)

To use RDP, you will first need to enable it on the target computer. Open the Settings app and go to System -> About. Then scroll down and click on Advanced system settings. You will be prompted to enter an administrator username and password.
 
Go to the Remote tab. Then click on Allow Remote Connections to this computer. Then click apply then ok.
 
Now you can go back to your admin machine and try to RDP into the client machine. To do this, open the Remote Desktop Connection app. Click Show Options to expand the page. Enter the machine’s name including the domain name as shown below. Also enter the admin username that you want to logon with. Then click connect and enter the password to that account. 
 
If a user is logged in on that machine, you will see a prompt asking you if you want to proceed and log that user off.
 
On the user end. They will see the following prompt. They have the option to allow or disallow the RDP connection.
 
You will know you are in a RDP session by looking at the top of your screen. You will see the name of the machine that you are connected to. You can exit the session by clicking the X on the right or signing out of the machine.
 

2.	Remote Assistance
RDP is useful for performing tasks on a user’s machine but it’s very disruptive. It forces the user to log off and they could potentially lose progress on their work. You can avoid this by using Remote Assistance. This allows you to remotely control a user’s machine.

To setup Remote Assistance, you will first need to enable it on the controlling computer. Go to sever manager and click Add Roles and Features.
 
Click next until you get to the features page. Check the box for Remote Assistance. Then continue to click next to the end to complete the installation.
 

Now you can create a GPO that will restrict access to only allow users in a certain security group to perform Remote Assistance. This will typically be the users who are in the IT OU and work as helpdesk.

To create the security group, Right click on the OU you want to create the security group in and select New -> Group. Give it a name that will be easy to understand later.
 
Now you can add users from the IT OU who have permission to use Remote Assistance. You can select those users and right click and select Add to group. 
 
Enter the name of the group you created then click Check Name to confirm. Then select ok.
 

With the security group created and the members added to it. You can now create the GPO. To create the GPO, go to Server Manager and go to Tools -> Group Policy Management. 
 
Navigate to the Group Policy Objects folder and right click and select New. Then give it a name.
 
Right click on the GPO you just created and select Edit.
 
Navigate to Computer Configuration -> Policies -> Software settings -> Administrative Templates -> System -> Remote Assistance. Click on Remote Assistance. Then double click Configure Offer Remote Assistance.
 
Click the Enabled radio button. Also make sure the Allow helpers to remotely control the computer is selected. Then Click the Show button.
 
Enter the name of the security group you create earlier. Then click apply then ok to finish editing the GPO.
 

Next, depending on your system, you might need to create a firewall rule to allow this connection to the client machine. Go back in the Remote Assistance GPO and navigate to Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Windows Firewall with Advanced Security -> Windows Firewall with Advanced Security -> Inbound Rules. Right click on Inbound Rules then select New Rule.
 
Click the Predefined radio button. Then select Remote Assistance from the drop-down menu.
 
Check the two rules below. Then click next.
 
Then click allow the connection. Then click finish.
 

Now you can open remote assistance and try to connect to the user’s machine. 
To do this, first click the windows start button and type in Remote Assistance. Click on the result “invite someone to connect to your PC and help you”.
 
Now click on “Help someone who has invited you”.
 
At the bottom, click on Advanced connection option for help desk.
 
Now you can type in the machine name or IP address of the target machine. Then click next.
 
On the client’s machine, they will see the window below. When the user clicks yes, then you will be able to take control of their computer.
 
You can request control of the client machine by clicking Request control.
 
The user will have to click yes to the window below to allow you to take control of their machine.
 

Sometimes for security reasons, it might be company policy that users are the ones to initiate the remote assistance. To do this, the client will have to click the windows start button and type in remote assistance. Click on the result “invite someone to connect to your PC and help you”.
 
Now click on “Invite someone you trust to help you”.
 
 Then click “Save this invitation as a file”
 
Save the file to your desktop then click ok. 
 
The following window will open and show the password to the Remote Assistance invite. The user can now send this file to the admin to get remote assistance.
 
You can also type \\%ClientName%\C$ in file explore to access their C drive. Then navigate to users -> ClientName -> desktop. Then you can open the file yourself. Then you can ask the user to tell you the password over the phone.
 



Notes:
This lab was inspired by the home lab video created by Josh Makador. https://www.youtube.com/watch?v=MHsI8hJmggI

