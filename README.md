# Active Directory Home Lab [Part 1]  
![image](https://jumpcloud.com/wp-content/uploads/2016/07/AD1.png)  

## Lab Overview  

This is a detailed step by step guide on how to create your own Active Directory home lab using Virtual Box. You will learn how to setup a test network consisting of one domain controller (Server 2019) and two client machines (Windows 10). This setup will reflect a typical corporate network by placing all client machines on an internal private network. All traffic to and from the internal network will be routed through the domain controller. This prevents the client machines from being exposed directly to the external internet. You will use Network Address translation to allow the client machines to access the internet through the domain controller. 

This setup gives the organization control over all users and client machines on the network. This makes managing access and permissions on the network much easier.

Once the test network is setup, you will then learn how to setup Active Directory and create Organizational Units. This will allow you to configure permissions and group policies for different Organizational Units and security groups.

You will also learn common active directory tasks such as creating new users, disabling users, and resetting passwords. You also learn to configured common group policy tasks such as mapping network drives, pre-installing required software onto machines, and enforcing custom wallpaper for each department.

Additional skills you will learn is how to remotely login into client machines using RDP and Remote Assistance to help with troubleshooting their system.

## Test Network Layout  
![image](https://user-images.githubusercontent.com/121589466/210327616-ee982539-ae84-4feb-8ee3-b91237116cf9.png)  

## Test Network Setup
The first step in setting up your test network is to download and install Virtual Box. It is a type 2 hypervisor which you will use to create virtual machines that will function as your servers and client machines.  
  1.	Download virtual box here:   
  https://www.virtualbox.org/wiki/Downloads  
  2.	Click the version that corresponds to your operating system.  
  ![image](https://user-images.githubusercontent.com/121589466/210327776-ac898d5d-f3d5-4379-833c-a09624e7e5ea.png)  
  3.	Also download Oracle VM Virtual Box Extension Pack and store it in the same location.  
  ![image](https://user-images.githubusercontent.com/121589466/210327790-680c0387-bb63-4a86-af8b-d87e9ec0486b.png)
<br><br />
You will also need to download the right operating systems which you will install onto the virtual machines. You will use Server 2019 for the domain controller and Windows 10 Enterprise for the client machines.  
  1.	Download the O.S evaluation images here:  
  https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2019  
  https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise  
  2.	Choose ISO format.  
  ![image](https://user-images.githubusercontent.com/121589466/210327841-215da2ac-4c60-4aa7-bf67-71f1e32e0d5e.png)  
  3.	Then fill out personal info to get to the download link. You can fill the form with bogus personal info if you don’t want to enter your real personal info.  
  ![image](https://user-images.githubusercontent.com/121589466/210327867-d079ba50-e10b-4bf7-bec4-0fca2cfbd553.png)  

## Create Domain Controller VM
Now that you have VirtualBox installed and downloaded the right operating systems, its time to create your first virtual machine. This will be the domain controller.  
  1.	Open VirtualBox and click the new button to start the process.  
  ![image](https://user-images.githubusercontent.com/121589466/210327955-4a55dc56-bbaf-43d0-8653-decc39b1b8bb.png)  
  2.	Name your virtual machine and select the location to store it. For O.S choose Microsoft Windows and “Other Windows” For the version. Then click next.  
  ![image](https://user-images.githubusercontent.com/121589466/210327965-f779af7c-3b4e-4d97-be17-2041295762fe.png)  
  3.	Give your virtual machine a minimum of 2GB of ram. You can increase this number later if your virtual machine is too slow. Then click next.  
  ![image](https://user-images.githubusercontent.com/121589466/210328001-c000aff2-799e-4ee3-939e-c68624feea72.png)  
  4.	Select “Create virtual hard disk now”. Then click next.  
  ![image](https://user-images.githubusercontent.com/121589466/210328020-eb8a6d35-f473-4da4-98b1-eef5cacbfee2.png)  
  5.	Choose VMDK as hard disk file type. VDI is typically used but I plan on uploading a snapshot of my VM onto GitHub. Therefor I choose VMDK because it will also work on other popular virtualization software like VMware. This will make it accessible to the largest number of people who want to use it.  
  ![image](https://user-images.githubusercontent.com/121589466/210328034-b87d2374-9722-469f-94d5-83f9d1bf5ac9.png)  
  6.	Leave the remaining settings at default. Click through to the end to finish creating the VM.

## Configure Domain Controller VM and Network Adapters
Now that the VM for the domain controller is created. Let’s configure the settings before you launch it.  
  1.	Click on the newly created VM and select the settings button.  
  ![image](https://user-images.githubusercontent.com/121589466/210328208-a31c6d3a-f958-4d68-b1a7-cc1fbc8a98db.png)  
  2.	Under General -> Advanced. Change “Shared Clipboard” and “Drag’n’Drop” to Bidirectional. This will allow you to use copy and paste between your personal computer and the VM.  
  ![image](https://user-images.githubusercontent.com/121589466/210328225-ff989798-3b63-46fd-ae3c-a03c8a787c38.png)  
  3.	Next, you will configure the external and internal network adapters on the VM. Go to Network -> Adapter 1. Change “Attached to” to NAT. This will allow the VM to connect to your home internet and get an IP address. 
  ![image](https://user-images.githubusercontent.com/121589466/210328257-2f4766bf-1224-400d-81f5-95f18a5c1cce.png)  
  4.	Click on “Adapter 2” and change “Attached to” to Internal Network. This will allow the domain controller to connect to the internal private network that the client computers will sit on.  
  ![image](https://user-images.githubusercontent.com/121589466/210328277-bc2a2feb-1fcf-4d18-a5a8-4120c48897ac.png)  

## Install Server 2019
The VM for the domain controller is now configured. You can now begin the process of installing Server 2019 onto the VM. 
  1.	Double click the VM to launch it.  
  ![image](https://user-images.githubusercontent.com/121589466/210328351-b23bb726-4672-4be9-a122-49d6762bae80.png)  
  2.	You will be prompted to add the disk image of the O.S you want to use. Navigate to the location where you saved it and select it. Then click start to start the VM.  
  ![image](https://user-images.githubusercontent.com/121589466/210328374-3444208d-72f4-48ed-9179-09e8c0878429.png)  
  You Can also add the disk by going to Devices -> Optical Drives -> Choose disk file.  
  ![image](https://user-images.githubusercontent.com/121589466/210328400-5aa9219b-3934-46bb-a0c0-468144e49c6d.png)  
    You will need to reset the VM after adding the disk this way.  
  ![image](https://user-images.githubusercontent.com/121589466/210328425-08b9867e-e036-48d5-9d1f-383646123b80.png)  
  3.	Now you will go through the standard windows installation.  
  ![image](https://user-images.githubusercontent.com/121589466/210329904-f8dc7a7c-4841-484f-a1b5-01fe45e69f63.png)
  4.	Choose Standard Evaluation (Desktop Experience). Click next.  
  ![image](https://user-images.githubusercontent.com/121589466/210329926-9f07c249-b15d-413e-bac6-d8a58024a4df.png)
  5.	Choose custom install. Click next.  
  ![image](https://user-images.githubusercontent.com/121589466/210329945-ec5b5f46-34f6-44c2-aa06-c26d37b80689.png)
  6.	It will prompt you to create password. Choose something you will remember.
  7.	It will take a long time to install but eventually you will get to welcome screen. You will need to go to Input -> keyboard -> Insert Ctrl-Alt-Del to bring up the logon page.  
  ![image](https://user-images.githubusercontent.com/121589466/210329957-73318c11-ecd2-4d3d-8d32-4ec8c0173b20.png)
  8.	After you logon. The VM will be very slow and lag a lot. The first thing you should do is go to Devices -> Insert Guest Additions CD image.  
  ![image](https://user-images.githubusercontent.com/121589466/210329971-2b677dec-0584-4242-870c-72ef85a59eed.png)
  9.	Then open file explorer and go to This PC. Double click on Virtual Guest Additions drive.  
  ![image](https://user-images.githubusercontent.com/121589466/210329996-e12e7eb8-6d97-448d-9ad5-ffc3b53b36b4.png)
  10.	Double click and install “VBoxWindowsAdditions-amd64”. Then restart the VM. This will improve the performance and make the VM run smoother and reduce the lag.  
  ![image](https://user-images.githubusercontent.com/121589466/210330015-ff60a9cf-9abc-4cd0-b3ec-40d86cff19af.png)
  11.	The next step is to now rename our server. This will give it a more human readable name that you can easily reference later. To change the name, go to settings -> about -> rename this pc.  
  ![image](https://user-images.githubusercontent.com/121589466/210330032-5e33bb68-a800-40fd-b14a-12f266b406d4.png)

## Configure Server Network Adapters
With the installation complete. you can now setup the network connections for the server.  
1.	Go to Control panel\ Network and Internet\ Network Connections.  
![image](https://user-images.githubusercontent.com/121589466/210330192-716ff9a2-019e-4590-a1c4-efd8680eda87.png)
2.	Right click on the connections and click status.  
![image](https://user-images.githubusercontent.com/121589466/210330200-ec72f156-49e9-4130-8402-bcc0e4cfcfca.png)
3.	Then click on details.  
![image](https://user-images.githubusercontent.com/121589466/210330216-e8533a88-5881-4a7c-a652-503b9f370026.png)
4.	Do this to both adapters and find the one with an IP of 169.254.XXX.XX. This is the one that has an auto configured IP.  
![image](https://user-images.githubusercontent.com/121589466/210330240-e3363d40-6e5b-4634-a126-4202632f1306.png)
5.	When you find this one. You will go back and right click on it and select Rename. Change the name to ‘Internal’. Then change the name of the other adapter to “External”. This will help you differentiate them later when configuring NAT.  
![image](https://user-images.githubusercontent.com/121589466/210330312-c1ad87c1-b462-420d-b84a-0aa57c9c03f1.png)
6.	With the adapter names properly changed, you can now configure the IP for the internal adapter. Go back to the internal network adapter and right click and select properties.  
![image](https://user-images.githubusercontent.com/121589466/210330328-9df8ab7a-f56f-4aac-a9ac-6cf44c778359.png)
7.	 Double click on internet protocol Version 4  
![image](https://user-images.githubusercontent.com/121589466/210330348-e2974acd-b814-40cc-9cbd-430832bada88.png)
8.	Click “use the following IP address”. Change the IP to the following below. The internal network is private so you will assign an IP address in the private address range. The default gateway will be blank since the domain controller will be the default gateway/router. You will also set the DNS server IP address to be the same as the domain controller server so that it can later be its own DNS server. You can then click ok to save the settings.  
![image](https://user-images.githubusercontent.com/121589466/210330376-172dfacf-b509-4ad8-a330-0bd7eb14c6fa.png)

## Install Active Directory 
You are now ready to install Active Directory on your server.  
1.	Start by opening Server Manager and selecting Manage -> Add Roles and Features.  
![image](https://user-images.githubusercontent.com/121589466/210330606-6edf5e43-d119-4d8a-b02e-7787f307cf74.png)
2.	Stick with the default choices and select next until you get to the page below. Click the box for “active directory domain services”. You can then continue to click next to the end.  
![image](https://user-images.githubusercontent.com/121589466/210330626-8423823d-7587-49f0-a0fc-631cf185afe5.png)
3.	That installation will take a while. Once it’s done, you will see a flag at the top of Server Manager. Click on it to open the drop down and click “Promote this server to a domain controller”. You have installed the services for active directory, but you still need to now configure it.  
![image](https://user-images.githubusercontent.com/121589466/210330646-76133843-c413-4c48-a309-b5b808b10c2a.png)
4.	Click Add a new forest and name your domain. Then click next.  
![image](https://user-images.githubusercontent.com/121589466/210330665-f7e7e0d3-b7ef-4d05-b64d-4544f4a942af.png)
5.	You will now create a password for your domain controller restore mode. Then click next to the end. You will need to then restart the computer and log back in.  
![image](https://user-images.githubusercontent.com/121589466/210330681-b0fd67eb-9682-4b72-a15b-fb85ac575acf.png)
6.	Now that Active Directory is installed, you don’t have to keep using the default built in account. You can now create a local administrator account that you can use to logon with going forward. To do that you can first create an Organizational Unit to store the admin accounts. You do this by opening “Active Directory Users and Computers. This can also be found under tools in the server manager.  
![image](https://user-images.githubusercontent.com/121589466/210330700-a7bb5bb0-b00d-40ef-bdf9-a345b3ecaaba.png)
7.	Right click the domain name and select New -> Organizational Unit.  
![image](https://user-images.githubusercontent.com/121589466/210330724-0673e4ef-23ab-4718-9e9d-ce4f5c921388.png)
8.	Give the Organizational Unit (OU) a name starting with an underscore (_) so that it will show up at the top of the list of Organizational Units.  
![image](https://user-images.githubusercontent.com/121589466/210330750-c328094e-875d-4861-bdae-4cb7e1e41503.png)
9.	Then right click on that newly created OU and go New -> User.  
![image](https://user-images.githubusercontent.com/121589466/210330782-52032299-c966-4549-89fe-e7586fba06d0.png)
10.	 Give the account a name and username you like.  
![image](https://user-images.githubusercontent.com/121589466/210331058-86a8a1ea-78ba-41cb-b5fa-26b079ab782c.png)
11.	Then create a password that you will remember. Uncheck user must change password and check password never expires.  
![image](https://user-images.githubusercontent.com/121589466/210331070-3702fed7-7c91-4a28-a54a-1c1c56c3b2bc.png)
12.	You’ve now created your account but it’s still just a standard user. To make it an administrator; right click on it and select properties.  
![image](https://user-images.githubusercontent.com/121589466/210331076-a33a129d-15f5-45e7-9283-9207ed0fca2d.png)
13.	Click on the “Member Of”. Then select Add.  
![image](https://user-images.githubusercontent.com/121589466/210331091-4138144a-f54a-465a-bc20-1140a8d8393c.png)
14.	Type in “Domain Admins” then click Check Names to make sure its correct. Then hit Apply. You can now log off and then log back in with your newly created account.  
![image](https://user-images.githubusercontent.com/121589466/210331101-d6678443-a897-485f-92a1-b496817d096e.png)
15.	When logging on. Select other user and then enter the username and password for the new account.  
![image](https://user-images.githubusercontent.com/121589466/210331117-654cf8e3-ff08-456c-8ba2-51d203acd9a6.png)

## Configure NAT/RAS
With Active Directory configured. You can now turn your sights to configuring the internal network for the client machines.
1.	In Server Manager, click Manage -> Add Roles and Features.  
![image](https://user-images.githubusercontent.com/121589466/210332645-d8ab9939-3eb8-4bdd-b050-4093f7f0516c.png)
2.	Click next until you get to the page below. Check the box for “Remote Access”.  
![image](https://user-images.githubusercontent.com/121589466/210332667-7dd8735d-7aa3-4215-a103-fb84b8c93b7f.png)
3.	Then on the next page, check the “Routing” box. Then click next to the end to finish installing the features.  
![image](https://user-images.githubusercontent.com/121589466/210332678-642cd9dc-bc2d-45b9-9d31-d0d93a75daf5.png)
4.	Once the installation is complete. Go to Server Manager and select Tools -> Routing and Remote Access.  
![image](https://user-images.githubusercontent.com/121589466/210332701-d085b87f-611b-4b68-8345-eaf927057a01.png)
5.	Right click on the domain controller server and select “Configure and Enable Routing and Remote Access”.
6.	Select Network address translation. Then click next.  
![image](https://user-images.githubusercontent.com/121589466/210332720-c32cb46f-2ff8-4dbd-8dcd-c8c919c74311.png)
7.	Select “Use this public interface to connect to the internet”. Then select the internet adapter that you named external or internet. Then click through to the end and finish the installation.

## Configure DHCP
Next step is to configure our domain controller to also serve as a DHCP server. This will allow the client machines on the internal private network to dynamically receive IP addresses when they join the network.
1.	In Server Manager. Click Add Roles and Features.  
![image](https://user-images.githubusercontent.com/121589466/210332785-cbe457f1-0cf0-4fac-aaff-a590cac16903.png)
2.	Click next until you get to the page below. Check the box for “DHCP Server”. Then click next to the end.  
![image](https://user-images.githubusercontent.com/121589466/210332792-3bfa1dd0-84f6-4f63-89fe-af428a29929f.png)
3.	After the installation, you can now configure DHCP by going to Tools -> DHCP.  
![image](https://user-images.githubusercontent.com/121589466/210332802-8b510884-45fd-49f0-b5a1-1d2d85cc3071.png)
4.	Right click on IPV4 and select New Scope.  
![image](https://user-images.githubusercontent.com/121589466/210332815-8bb6b8c7-821c-4d41-a125-dabf1f4d771d.png)
5.	Enter the following IP ranges and subnet masks of addresses that the server can give out. Then click next until you get to the next page.  
![image](https://user-images.githubusercontent.com/121589466/210332829-4ddc3bd8-a9de-4768-a290-99033a5314ae.png)
6.	Click Yes. I want to configure these options now. Click next until you get to the next page.  
![image](https://user-images.githubusercontent.com/121589466/210332865-770d9c91-49e4-4c77-b31a-865bed62b2e0.png)
7.	Now enter the IP address of the domain controller server. This will allow it to function as a router and be the default gateway for the internal network. Then click next.  
![image](https://user-images.githubusercontent.com/121589466/210332871-bb58d5dc-4caf-49e6-92fb-e9c33bc93db1.png)
8.	 Click Yes, I want to activate this scope now.  
![image](https://user-images.githubusercontent.com/121589466/210332888-897ccb80-64d9-49fa-8310-b27ab7116eca.png)
9.	Now that you have installed and configured DHCP, right click on Server Options and select Configure Options. Make sure that Router is selected as an option. Also check that the IP address is the same as the domain controller server.  
![image](https://user-images.githubusercontent.com/121589466/210332907-8d04dfb1-9655-43bc-ac67-c7244a80bdff.png)
10.	Once that is confirmed, you can right click on the server name and select Authorize.  
![image](https://user-images.githubusercontent.com/121589466/210332927-f52347bf-4b0e-432d-a665-a3652e66cca3.png)
11.	Then you can right click on the server and select Refresh to update it. Now there should be a green check mark next to the IPV4 option.  
![image](https://user-images.githubusercontent.com/121589466/210332948-486d1eef-c70b-43df-8a42-2683a84f4062.png)  
Now the clients on the internal network will be able to receive an IP address when they connect to the network and be able to access the internet.  

## Import 100 users Using PowerShell  
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
![image](https://user-images.githubusercontent.com/121589466/210333175-a389bc79-be9f-49de-bccd-13521382c3f8.png)

## Create Client Machines
The last major step is to create the client machines that will live on the private internal network. The process is very similar to setting up the domain controller server so I will go through this more quickly and highlight the steps that are different.
1.	In VirtualBox. Press the New button and create the VM that your client will run on. The version will be Windows 10. Give the VM atleast 4GB ram.  
![image](https://user-images.githubusercontent.com/121589466/210333282-d3207c94-08f8-4353-a90a-49ae653524c5.png)
2.	After creating the VM. Right click on it and go to settings. Go to General -> Advanced. Change shared clipboard and the Drag’n’ drop settings to Bidirectional.  
![image](https://user-images.githubusercontent.com/121589466/210333298-d115a5a2-a262-4b8e-b278-a6f21a60583b.png)
3.	Also, in the settings pane. Go to Network -> Adapter 1. Change “Attached to” to Internal network.  
![image](https://user-images.githubusercontent.com/121589466/210333321-6895c12d-eea4-49f3-b776-0102a66192ad.png)
4.	Now you can launch the VM and load the Windows 10 Enterprise disk to begin installation. If asked to create a Microsoft account; Look for alternate options like “setup without internet” or “Join a domain instead”. Follow the standard installation process then proceed to the next step.
5.	After installation, the first thing to do is install “VBoxWindowsAdditions-amd64” so that the VM can run better. You do this by going to Devices -> Insert Guest Additions CD image.  
![image](https://user-images.githubusercontent.com/121589466/210333346-5edc3699-717a-4348-bfe7-f55ec08db473.png)
6.	Then open file explorer and go to This PC. Double click on Virtual Guest Additions drive.  
![image](https://user-images.githubusercontent.com/121589466/210333357-2c471abe-90b9-4f2d-8368-b0a270651a26.png)
7.	Double click and install “VBoxWindowsAdditions-amd64”. Then restart the VM.  
![image](https://user-images.githubusercontent.com/121589466/210333369-6f58ced0-9de6-4b52-8007-3878db1b50e8.png)
8.	After those steps, you will need to make sure that our client machine can connect to the internet. Open PowerShell and enter the Ipconfig command to make sure you are connected to the internal private network and can also reach the internet. You can also ping a known site like google using the command “ping google.com”  
![image](https://user-images.githubusercontent.com/121589466/210333381-ef877bfc-2414-4c5a-8661-c04d707f7042.png)

## Join Client to Domain
The client OS installation is complete and is now connected to the network. You can now move on to joining it to the domain you created earlier.  
1.	The first step is to give our client a more human readable name. To change the name, go to Settings -> About -> Rename this PC (advanced).  
![image](https://user-images.githubusercontent.com/121589466/210333590-2050aa9a-c273-45ef-953e-969e68d56bc6.png)
2.	Click on Change.  
![image](https://user-images.githubusercontent.com/121589466/210333607-82bb1afa-3241-422b-8b59-bcbbac9a292d.png)
3.	Give your computer a new name. Also click “member of domain:”.  Enter the name of the domain you created. Then click next. You will be prompted to enter the credentials of an account that is already on that domain. That is used to verify that you have permission to join that domain.  
![image](https://user-images.githubusercontent.com/121589466/210333622-ddfa27c8-0c6d-4276-b2e3-58b002bc9f10.png)
4.	If successful, you will see something similar to this below.  
![image](https://user-images.githubusercontent.com/121589466/210333638-3a34242b-8da8-422b-b254-6aed1af9366f.png)
5.	You can confirm that the client has joined the domain by going back to the domain controller and going to the DHCP tool in Server Manager. Under address leases, you should see the client machine there.  
![image](https://user-images.githubusercontent.com/121589466/210333656-9cfb95c0-c1dd-42b6-b201-b771c535950f.png)
6.	Also in active directory, if you look in the computers folder. You should see the client there also.  
![image](https://user-images.githubusercontent.com/121589466/210333667-b6ad4421-c48f-44e4-b858-08f9f9c23734.png)

## Clone VM
Your first client computer is now configured. You can do the same exact steps to also create the second client computer on your virtual network. You can also make the process of creating more virtual machines easier by creating a clone of the first client machine.  

1.	To create a clone of a VM in VirtualBox. Make sure the VM is powered off first. Then right click on the VM and select Clone.  
![image](https://user-images.githubusercontent.com/121589466/210333794-476c9a59-d226-4ffd-a16e-152f5b908741.png)
2.	Give the clone a unique name. Then choose the location to save the new VM.  For Mac Address Policy, change the drop-down menu to Generate new MAC addresses for all network adapters. Then click Next.  
![image](https://user-images.githubusercontent.com/121589466/210333812-6efbcbd3-7b00-4ae0-ac6e-f7c519c59ae8.png)
3.	Choose full clone. Then click the Clone button.  
![image](https://user-images.githubusercontent.com/121589466/210333828-f8ffa91b-4dd7-48df-8621-8bd2ec91a5fd.png)
4.	This progress screen will pop-up and it might take a while to create a clone of your machine.  
![image](https://user-images.githubusercontent.com/121589466/210333853-d7046f24-ef6f-4e7c-9648-19aa5727981a.png)
5.	Once the cloning process is done. You will now have another VM in VirtualBox that you can deploy and configure as Client2.

6.	To configure this new VM. You will have to power it on and first change its name. To change the name, go to Settings -> About -> Rename this PC (advanced).  
![image](https://user-images.githubusercontent.com/121589466/210333880-2c4d1a4d-052f-47f7-b695-b92335e761af.png)
7.	Click on Change.  
![image](https://user-images.githubusercontent.com/121589466/210333899-5d4bfc3d-8396-43c3-bb81-ff2e6be0600a.png)
8.	Give your machine a new name. You will also have to re-authorize the machine to be on the domain. You do this by first removing it from the domain. Change “Member of” to Workgroup and give it a name of WORKGROUP. Then click ok and restart the machine.  
![image](https://user-images.githubusercontent.com/121589466/210333912-b329e3e5-97bf-49ca-a644-1a1702d8e03a.png)  
9.	Now you can go back and re-add this machine to the domain. You will be prompted to authenticate using the username and password of a user account that is on the domain. Then restart the machine to apply the changes.  
![image](https://user-images.githubusercontent.com/121589466/210333930-7f29a0ca-3643-4540-a232-b1babacd5660.png)  
10.	You should now see this new machine show up in Active Directory Users and Computers. Look in the Computers folder to see the new machine.  
![image](https://user-images.githubusercontent.com/121589466/210333947-2f1e834d-3023-483f-8447-582a3cd6d378.png)  


