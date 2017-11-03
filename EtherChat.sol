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

contract EtherChat {
    struct Message {
        address Sender;
        address Recipient;
        string TitleOfMessage;
        string MessageContents;
        bool IsUrgent;
    }
    
    struct ContactInformation {
        string Name;
        string UserHomeCountry; 
        string PhotoURL; 
        address UserAddress;
        uint PhoneNumber;
    }
    
    /** Add a struct for requesting certain currencies **/
    
    mapping (address => mapping (address => mapping (uint => Message))) Conversation;
    mapping (address => mapping (address => uint)) ConversationLength; 
    mapping (address => mapping (address => ContactInformation)) Contact;
    mapping (address => bool) HasNewMessage;  
    
    function EtherChat() {
        
    }
    
    function SendNewMessage(address _recip, string _title, string _contents, bool _urgent) payable {
        Conversation[msg.sender][_recip][ConversationLength[msg.sender][_recip]] 
            = Message(msg.sender, _recip, _title, _contents, _urgent);
            
        ConversationLength[msg.sender][_recip]++;
    }
    
    function AddAsContact(address _contactAddress, string _name_of_contact,
    string HomeCountry, string URL, address useraddress, uint phone) {
        Contact[msg.sender][_contactAddress] = 
        ContactInformation(_name_of_contact, HomeCountry, URL, useraddress, phone);
    }
    
    function NewMessage() constant returns (Message) {
        require(HasNewMessage[msg.sender] == true);
    }
    
    function ViewContact(address _contact) constant returns (ContactInformation) {
        return Contact[msg.sender][_contact];
    }
    
    function ShowMyConversation(address _recipient) constant returns (Message){
        
    }
}
