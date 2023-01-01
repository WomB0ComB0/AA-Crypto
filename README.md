# AA-Crypto <br/>
A way for people to be rewarded for having good attendance to Alcoholics Anonymous, only possible through blockchain and DeFi. It also allows donators to get charity tax breaks without actually spending any money.<br/>

# Why use us? <br/>
<b> Patients <b/> - Pledge a certain amount while also making a responsible financial decision, and be rewarded even more money for actually trying to recover <br/>
<b> Donators <b/> - Lock up funds, profits are given to patients who have good attendance, and receive tax breaks from not actually spending any money.

# Explanation <br/>
1. users can lock up however much they want, it can double purpose to be a pledge AND also a way to invest and make money. 

2. Donators can donate/ lock up their funds, if they hit x amount of money locked, they get a corresponding NFT to show proof, and possibly we track data so maybe in the future governments will give tax breaks.

3. We combine user funds + donator funds to return 5% a year on the entire pool.

4. At the end of the year/term, users who get good attendance get rewards. 
they get: <br/>
     i. their initial deposit + 5% apy <br/>
     ii. an equal cut (amongst other people who have good attendance) of all the profits of the entire pool from whatever is leftover. <br/>

For example: 
 1. Users + donators deposit into pool. There are 20,000 users. Lets assume users pledge random amounts each. The pool has $70,000,000 in it. $2,000,000 of it is pledges.
2. 1 year goes by. $70M turns into $73,500,000,   15,000 students have good attendance.
3. So about $  21,000,000  is given back to all users. About $1,000,000 in profit is given to users who have good attendance. 
4. Users who do not have good attendance get their original pledge back only.
5. Donators are also given back their original deposits.
6. Donators are minted NFT's corresponding to how much or long they have donated
7. Users who have good attendance get part of the entire pool's leftover profit. 
($3,500,00 profit - $1,000,000 pledge winners = $2,500,000 leftover profit)
$2,500,000 is distributed evenly to 15,000 users who have good attendance.
$2,500,000 / 15,000 = $166 per winner

if User Amir pledged $10,000 they would receive $666 profit at the end of the year.
if User Bob pledged $1000, they would receive $216 profit at the end of the year.
if User Mary pledged $0, they would receive $166 profit at the end of the year. 


# RecoveryTech.sol <br/>
There are several contracts that make this program: <br/>
1. <b>AA core </b>
Admin deploys this contract, it handles all the logic for the program. <br/><br/>
__<b>Admin Functions:</b>__ <br/>
<b>`addManager()` / `removeManager()`</b> : allows the admin to add or remove authorized manager crypto wallet addresses <br/>
<b>`addUsers()` :</b> allows the admin to add patients/users to the allowed list wallets able to participate <br/>
<b>`startProgram()` : </b> close deposits for patients and donators, and begins investment strategies (providing liquidity to Stargate Finance for <b>5-10% apy <br/>)
<b>`endProgram()` : </b> ends investment strategies and opens withdrawals for all users. <br/> <br/>
<b> Manager functions : </b> <br/>
<b> `startMeeting()` : </b> Starts a new meeting, enables attendance taking for patients. <br/>
<b> `endMeeting()` : </b> ends the meeting, disables attendance taking for patients. <br/>
<b> `takeAttendance()` : </b> allows manager to mark patients as absent or present <br/> <br/> <br/>
<b> User Functions : </b> <br/>
<b> `pledge()` :</b> allows patients to pledge a certain amount of $. they will receive at least 5% profit.<br/>
<b> `userWithdraw()`: <br/> allows patient to receive their initial pledge + 5% + the rest of the pool profit. <br/> <br/>
<b> Donator Functions: </b> <br/>
<b> `donate()` : </b> allows donators to donate $, and potential charity tax write offs. <br/>
<b> `donatorWithdraw()` : <br/> allows donators to receive their initial deposit <br/>
<b> `mintNFTs()` : <br/> donators can mint NFT's according to how much they have donated/locked up. <br/> <br/>
<b> Utility Functions: <b> <br/>
<b> `checkIfUser()`: returns true or false to check if an entered address is a patient. <br/>
<b> `isProgramStarted()` : <br/> returns true or false to check if the program is started by the admin. <br/> <br/>

2. <b> `OneHundredDonated`, OneThousandDonated, TenThousandDonated, OneHundredThousandDonated, OneMillionDonated, TenMillionDonated </b> <br/>
NFT contracts to be awarded to donators who hit a certain amount of $ donated. for example, if $100 is donated they would receive the `OneHundredDonated` NFT.






