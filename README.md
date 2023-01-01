# AA-Crypto <br/>
A way for people to be rewarded for having good attendance to Alcoholics Anonymous, only possible through blockchain and DeFi. It also allows donators to get charity tax breaks without actually spending any money.<br/>
# RecoveryTech.sol <br/>
There are several contracts that make this program: <br/>
1. <b>AA core </b>
Admin deploys this contract, it handles all the logic for the program. <br/><br/>
__<b>Admin Functions:</b>__ <br/>
<b>`addManager()` / `removeManager()`</b> : allows the admin to add or remove authorized manager crypto wallet addresses <br/>
<b>`addUsers()` :</b> allows the admin to add patients/users to the allowed list wallets able to participate <br/>
<b>`startProgram()` : </b> close deposits for patients and donators, and begins investment strategies (providing liquidity to Stargate Finance for <b>5-10% apy </b>)
<b>`endProgram()` : </b> ends investment strategies and opens withdrawals for all users. <br/> <br/>
<b> Manager functions : </b> <br/>
<b> `startMeeting()` : <b/> Starts a new meeting, enables attendance taking for patients. <br/>
<b> `endMeeting()` : <b/> ends the meeting, disables attendance taking for patients. <br/>
<b> `takeAttendance()` : <b/> allows manager to mark patients as absent or present <br/> <br/> <br/>
<b> User Functions : <b/> <br/>
<b> `pledge()` :<b/> allows patients to pledge a certain amount of $. they will receive at least 5% profit.<br/>
<b> `userWithdraw()`: <br/> allows patient to receive their initial pledge + 5% + the rest of the pool profit. <br/> <br/>
<b> Donator Functions: <b/> <br/>
<b> `donate()` : <b/> allows donators to donate $, and potential charity tax write offs. <br/>
<b> `donatorWithdraw()` : <br/> allows donators to receive their initial deposit <br/>
<b> `mintNFTs()` : <br/> donators can mint NFT's according to how much they have donated/locked up. <br/> <br/>
<b> Utility Functions: <b> <br/>
<b> `checkIfUser()`: returns true or false to check if an entered address is a patient. <br/>
<b> `isProgramStarted()` : <br/> returns true or false to check if the program is started by the admin. <br/> <br/>

2. <b> `OneHundredDonated`, OneThousandDonated, TenThousandDonated, OneHundredThousandDonated, OneMillionDonated, TenMillionDonated </b> <br/>
NFT contracts to be awarded to donators who hit a certain amount of $ donated. for example, if $100 is donated they would receive the `OneHundredDonated` NFT.






