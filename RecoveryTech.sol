// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AA is Ownable {

    //manager variables
    address[] public managerArr;
    mapping(address => bool) public isManager;

    //user variables
    mapping(address => userProfile) public addressToProfile;

    //donator variables
    mapping(address => uint) public donatedAmount;


    //utility variables
    bool programStarted;
    bool programEnded;
    bool collectFunds;
    
    mapping(uint => group) numToGroup;
    uint programCounter;

    

    struct group {
        uint8 year;
        address[] users;
        uint highestStreak;
        bool meetingInSession;
        uint256 totalDeposits;
        uint256 totalFunds;
        uint256 totalProfits;
    }


    struct userProfile {
        bytes name;
        uint totalVisits;
        uint streakCounter;
        uint highestStreak;
        uint pledgeAmount;
        uint withdrawAmount;
        
    }

    OneHundredDonated oneHundredDonatedNFT;
    OneThousandDonated OneThousandDonatedNFT;
    TenThousandDonated TenThousandDonatedNFT;
    OneHundredThousandDonated OneHundredThousandDonatedNFT;
    OneMillionDonated OneMillionDonatedNFT;
    TenMillionDonated TenMillionDonatedNFT;

    constructor() {
        
        programCounter = 1;

        oneHundredDonatedNFT = new OneHundredDonated();
        OneThousandDonatedNFT = new OneThousandDonated();
        TenThousandDonatedNFT = new TenThousandDonated();
        OneHundredThousandDonatedNFT = new OneHundredThousandDonated();
        OneMillionDonatedNFT = new OneMillionDonated();
        TenMillionDonatedNFT = new TenMillionDonated();


    }

    //ADMIN COMMANDS

    function addManager(address _address) onlyOwner public {

        require(isManager[_address] == false, "address is already manager");

        isManager[_address] = true;

        managerArr.push(_address);
        
    }

    function removeManager(address _address) onlyOwner public {
  
        require(isManager[_address] == true, "address is not a manager"); 
        isManager[_address] = false;
    }

    //add users to group array
    function addUsers(address _address) onlyOwner public {
        require(!programStarted);
        numToGroup[programCounter].users.push(_address);
    }


    function createProgram(uint8 _year) onlyOwner public  {
        
        require(!programStarted, "program not started");
        group memory newProgram;
        numToGroup[programCounter] = newProgram;
        newProgram.year = _year;
        programStarted = true;
        programCounter++;
        collectFunds = true;
        programEnded = false;
    }

    function startProgram() onlyOwner public {
        collectFunds = false;

        //execute trading strategy
      
        //providing liquidity to stargate finance
        //providing liquidity to uniswap, etc. 

        IERC20 USDC = IERC20(0x27F8D03b3a2196956ED754baDc28D73be8830A6e);
        ICurve_Stable_Pool curvePool = ICurve_Stable_Pool(0x445FE580eF8d70FF569aB36e80c647af338db351);
        uint[3] memory USDCamount = [USDC.balanceOf(address(this)),0,0];
        USDC.approve(address(curvePool), type(uint256).max);
        // Deposit funds into Curve's Polygon AAVE Stablecoin Pool
        uint actual_LP_token_amount = ICurve_Stable_Pool(curvePool).add_liquidity(USDCamount,0);
    }

    function endProgram() onlyOwner public {
        //set programStarted to false
        programEnded = true;
        programStarted = false;
        
        address stableLP = 0x445FE580eF8d70FF569aB36e80c647af338db351;
        //end investments
        uint LPTokens = IERC20(stableLP).balanceOf(address(this));

     
        address curvePool = 0x445FE580eF8d70FF569aB36e80c647af338db351;
        ICurve_Stable_Pool(curvePool).remove_liquidity(LPTokens , 0 ); 

        //return funds
        uint beginningDeposits = numToGroup[programCounter].totalDeposits;
        uint allFunds = numToGroup[programCounter].totalFunds;

        numToGroup[programCounter].totalProfits = beginningDeposits - allFunds;
 
    }

    //MANAGER COMMANDS

    function startMeeting() public {
        require(programStarted);
        numToGroup[programCounter].meetingInSession = true;

    }

    function endMeeting() public {
        require(programStarted);
        require(numToGroup[programCounter].meetingInSession);
        numToGroup[programCounter].meetingInSession = false;
    }

    function takeAttendance(address _address, bool _attended) public {
       require(programStarted, "program not started");
       require(isManager[msg.sender], "caller is not a manager");
       require(checkIfUser(programCounter, _address), "address entered is not a user");
       require(numToGroup[programCounter].meetingInSession);
       
       if (_attended){
       addressToProfile[_address].totalVisits++;
       addressToProfile[_address].streakCounter++;
        if(addressToProfile[_address].streakCounter > addressToProfile[_address].highestStreak){
           addressToProfile[_address].highestStreak = addressToProfile[_address].streakCounter;
        }
       }
       else{
           addressToProfile[_address].streakCounter = 0;
       }
    }


    //USER COMMANDS

    function pledge(uint amount) public {
        require(collectFunds, "deposits locked");
        //usdc address: 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174
        require(checkIfUser(programCounter ,msg.sender), "not registered");
        IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174).transferFrom(msg.sender, address(this), amount);
        addressToProfile[msg.sender].pledgeAmount += amount;
    }

    function userWithdraw() public {

    }


    


    //DONATOR COMMANDS

    function donate(uint amount) public {
        require(collectFunds, "deposits locked");
        IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174).transferFrom(msg.sender, address(this), amount);
        donatedAmount[msg.sender] += amount;
    }

    function donatorWithdraw() public {
        
    }

    function mintNFTs() public {
        require(donatedAmount[msg.sender] > 1 ether,"You didn't donate SHIET");
        if(donatedAmount[msg.sender] >= 100 ether && donatedAmount[msg.sender] < 1000 ether) {
            oneHundredDonatedNFT.mint();
        }
        if(donatedAmount[msg.sender] >= 1000 ether && donatedAmount[msg.sender] < 10000 ether) {
            OneThousandDonatedNFT.mint();
        }
        if(donatedAmount[msg.sender] >= 10000 ether && donatedAmount[msg.sender] < 100000 ether) {
            TenThousandDonatedNFT.mint();
        }
        if(donatedAmount[msg.sender] >= 100000 ether && donatedAmount[msg.sender] < 1000000 ether) {
            OneHundredThousandDonatedNFT.mint();
        }
        if(donatedAmount[msg.sender] >= 1000000 ether && donatedAmount[msg.sender] < 10000000 ether) {
            OneMillionDonatedNFT.mint();
        }
        if(donatedAmount[msg.sender] >= 10000000) {
            TenMillionDonatedNFT.mint();
        }
    }

    //UTILITY FUNCTIONS
    //put system in place to check if a user is in an incoming list
    //kind of gas intensive to read from
    function checkIfUser(uint _group, address _address) public view returns(bool isUser){
        
        for(uint i; i < numToGroup[_group].users.length; i++){
            if(numToGroup[_group].users[i] == _address) {
                isUser = true;
            }
            else{
                isUser = false;
            }
        }

    }


    //GETTER FUNCTIONS
    function getPledge(address _address) public view returns (uint256) {
        return addressToProfile[_address].pledgeAmount;

    }

    function isProgramStarted() public view returns (bool) {
        return programStarted;
    }

    

}
contract OneHundredDonated is ERC721Enumerable {

    AA _AAcore;
    address AAcore;
    //strings library
    using Strings for uint256;
    //Metadata link
    string _baseTokenURI;
    uint tokenId;

    constructor(/*_baseTokenURI*/) ERC721("OneHundredDonated","AA") {
        /*_baseTokenURI = baseURI;*/
        AAcore = address(_AAcore);
    }


    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }


    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

    function mint() public {
        require(msg.sender == AAcore);
        tokenId++;
        _mint(msg.sender,tokenId);

    }

}

contract OneThousandDonated is ERC721Enumerable {
    AA _AAcore;
    address AAcore;
    //strings library
    using Strings for uint256;
    //Metadata link
    string _baseTokenURI;

    uint tokenId;

    constructor() ERC721("OneThousandDonated","AA") {
            AAcore = address(_AAcore);
    }

    function mint() public {
        require(msg.sender == AAcore);
        tokenId++;
        _mint(msg.sender,tokenId);

    }


    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }


    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
   
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }


    

}

contract TenThousandDonated is ERC721Enumerable {
    AA _AAcore;
    address AAcore;
    //strings library
    using Strings for uint256;
    //Metadata link
    string _baseTokenURI;
    uint tokenId;
    constructor() ERC721("TenThousandDonated","AA") {
        AAcore = address(_AAcore);
    }

    function mint() public {
        require(msg.sender == AAcore);
        tokenId++;
        _mint(msg.sender,tokenId);

    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }


    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

}

contract OneHundredThousandDonated is ERC721Enumerable {
    AA _AAcore;
    address AAcore;
    //strings library
    using Strings for uint256;
    //Metadata link
    string _baseTokenURI;
    uint tokenId;

    constructor() ERC721("OneHundredThousandDonated","AA") {
        AAcore = address(_AAcore);
    }

    function mint() public {
        require(msg.sender == AAcore);
        tokenId++;
        _mint(msg.sender,tokenId);

    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }


    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

}

contract OneMillionDonated is ERC721Enumerable {
    AA _AAcore;
    address AAcore;
    //strings library
    using Strings for uint256;
    //Metadata link
    string _baseTokenURI;
    uint tokenId;
    constructor() ERC721("OneHundredThousandDonated","AA") {
        AAcore = address(_AAcore);
    }

    function mint() public {
        require(msg.sender == AAcore);
        tokenId++;
        _mint(msg.sender,tokenId);

    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }


    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

}

contract TenMillionDonated is ERC721Enumerable {
    AA _AAcore;
    address AAcore;
    //strings library
    using Strings for uint256;
    //Metadata link
    string _baseTokenURI;
    uint tokenId;
    constructor() ERC721("OneHundredThousandDonated","AA") {
        AAcore = address(_AAcore);
    }

    function mint() public {
        require(msg.sender == AAcore);
        tokenId++;
        _mint(msg.sender,tokenId);

    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }


    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

}


interface IERC20 {
        function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}

interface ICurve_Stable_Pool {
    function calc_token_amount(uint256[3] memory _amounts, bool _is_deposit) external returns (uint256);

    function add_liquidity(uint256[3] memory _amounts, uint256 _min_mint_amount) external returns (uint256);

    function remove_liquidity(uint256 _amount, uint256 _min_amounts) external returns (uint256);
}







