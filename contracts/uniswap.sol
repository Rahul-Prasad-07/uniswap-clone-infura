// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Customtoken is ERC20 {

    // this contract is child of erc20 contract for minting . it has bunch of erc20 token

    constructor (string memory name , string memory symbol) ERC20(name,symbol){
        _mint(msg.sender,100000*10**18);
    }
}

contract Uniswap{

    string[] public tokens = ['CoinA','CoinB', 'CoinC'];

     // map to maintain the tokens and its instances
     mapping (string => ERC20) public tokenInstantMap; // this mapping later on help to featch all this coins way easier--> return ERC20 address.
     
     // 1 CoinA/CoinB/COinC = 0.0001 eth
     uint EthValue = 100000000000000;

      // 0.0001 eth = 1 CoinA/CoinB/CoinC
      // 1 CoinA/CoinB/CoinC = 1 CoinA/CoinB/CoinC

    constructor (){
        for(uint i =0; i<tokens.length; i++){
            Customtoken token = new Customtoken(tokens[i],tokens[i]);  //constructor need two input we gave same name to both name and symbol
            tokenInstantMap[tokens[i]] =token; // store new token in mapping 

        }
    }

    // GetBalance function will take token name and your address and give you balance by calling balanceOf function that coming from ERC20

    function GetBalance(string memory tokenName, address _address) public view returns(uint256) {
        return tokenInstantMap[tokenName].balanceOf(_address);
    }


   function GetName(string memory tokenName) public view returns(string memory) {
       return tokenInstantMap[tokenName].name();
   }

     function getTotalSupply(string memory tokenName) public view returns (uint256) {
        return tokenInstantMap[tokenName].totalSupply();
    }
 
   function GetTokenAddress(string memory tokenName) public view returns (address) {
       return address (tokenInstantMap[tokenName]);
   }

    function getEthBalance() public view returns (uint256) {
        return address(this).balance;
    }

   function SwapEthToToken(string memory tokenName ) public payable returns (uint) {
       uint inputValue = msg.value;
       uint outputValue =(inputValue/EthValue) * 10 ** 18; //convert to 18 decimal value 
       require (tokenInstantMap[tokenName].transfer(msg.sender , outputValue));
       return outputValue;

       // bcz of this constructor i alredy have access to bunch of eth & tokens so those are alredy there
   }

   function SwapTokenToEth (string memory tokenName, uint _amount) public returns (uint){

       uint excatAmount = _amount/10 **18;
       uint ethToBeTransfered = excatAmount*EthValue;

       require(address(this).balance >= ethToBeTransfered,"Dex is running low on balance");
       payable(msg.sender).transfer(ethToBeTransfered);
       require(tokenInstantMap[tokenName].transferFrom(msg.sender,address(this), _amount));
       return ethToBeTransfered;
   }

    function swapTokenToToken(string memory srcTokenName, string memory destTokenName, uint256 _amount) public {
        require(tokenInstantMap[srcTokenName].transferFrom(msg.sender, address(this), _amount));
        require(tokenInstantMap[destTokenName].transfer(msg.sender, _amount));
    }

//     function GetEThBalance() {}
 }