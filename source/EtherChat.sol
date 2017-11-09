/*****************
File: EtherChat.sol

Title: EtherChat - Chat with friends on the Ethereum Blockchain
Purpose: Send and receive messages to friends, and add friends as contacts.

Author Name: Brett Harvey

To Compile: $ truffle compile
To Run:
$ truffle console
> etherchat.deployed().then(function(instance) { etherchatContract = instance });
*****************/

pragma solidity ^0.4.16;

 /*-----------------------
 Contract: EtherChat
 ------------------------*/
contract EtherChat {

  struct Message {
    address Sender;
    address Recipient;
    string TitleOfMessage;
    string MessageContents;
    uint EtherSent;
  }

  mapping (address => uint) public ECHAT;
  mapping (address => string) public Username;
  mapping (address => mapping (uint => Message)) public MyMessage;
  mapping (address => uint) NumberOfMessages;

  event NewMsg(address recip, address sender, string title, string contents);

  /*-----------------------
  Function: SendMessage()
  Purpose: Send a message to another EtherChat member.
  Parameters: address, string, string. Payable
  Returns: Nothing
  ------------------------*/
  function SendMessage(address _recip, string _title, string _contents) payable {
    Message storage NewMessage;
    NewMessage.Sender = msg.sender;
    NewMessage.Recipient = _recip;
    NewMessage.TitleOfMessage = _title;
    NewMessage.MessageContents = _contents;
    NewMessage.EtherSent = msg.value;

    MyMessage[_recip][NumberOfMessages[_recip]] = NewMessage;
    NumberOfMessages[_recip]++;
    NewMsg(_recip, msg.sender, _title, _contents);
  }

  /*-----------------------
  Function: GetMessageSenderUsername()
  Purpose: Gets the username of the message sender.
  Parameters: i
  Returns: String
  ------------------------*/
  function GetMessageSenderUsername(uint i) public constant returns (string) {
    Message msgSender = MyMessage[msg.sender][i];
    return Username[msgSender.Sender];
  }

  /*-----------------------
  Function: GetMessageSenderAddress()
  Purpose: Constructor function that runs once upon execution.
  Parameters: none
  Returns: nothing
  ------------------------*/
  function GetMessageSenderAddress(uint _i_) public constant returns (address) {
    Message _Sender = MyMessage[msg.sender][_i_];
    return _Sender.Sender;
  }

  /*-----------------------
  Function: GetMessageSenderUsername()
  Purpose: Gets the username of the message sender.
  Parameters: i
  Returns: String
  ------------------------*/
  function GetMessageTitle(uint i_) public constant returns (string) {
    Message msgTitle = MyMessage[msg.sender][i_];
    return msgTitle.TitleOfMessage;
  }

  /*-----------------------
  Function: GetMessageSenderUsername()
  Purpose: Gets the username of the message sender.
  Parameters: i
  Returns: String
  ------------------------*/
  function GetMessageContent(uint _i) public constant returns (string) {
    MyMessage[msg.sender][_i];
  }

  /*-----------------------
  Function: GetMessageSenderUsername()
  Purpose: Gets the username of the message sender.
  Parameters: i
  Returns: String
  ------------------------*/
  function GetMessageEtherSent(uint __i) public constant returns (uint) {
    Message msgEth = MyMessage[msg.sender][__i];
    return msgEth.EtherSent;
  }

  /*-----------------------
  Function: GetMessageSenderUsername()
  Purpose: Gets the username of the message sender.
  Parameters: i
  Returns: String
  ------------------------*/
  function GetEtherBalance() public constant returns (uint) {
    return msg.sender.balance;
  }

  /*-----------------------
  Function: GetMessageSenderUsername()
  Purpose: Gets the username of the message sender.
  Parameters: i
  Returns: String
  ------------------------*/
  function GetTokenBalance() public constant returns (uint) {
    return ECHAT[msg.sender];
  }

  /*-----------------------
  Function: CreateMyUsername()
  Purpose: Gets the username of the message sender.
  Parameters: i
  Returns: String
  ------------------------*/
  function CreateMyUsername(string username) {
    Username[msg.sender] = username;
  }
}
