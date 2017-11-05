
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
abi = JSON.parse('contract abi goes here')
VotingContract = web3.eth.contract(abi);
// In your nodejs console, execute contractInstance.address to get the address at which the contract is deployed and change the line below to use your deployed address
contractInstance = VotingContract.at('contract address goes here');

function UrgentSendMessage() {
  useraddress = $("#RecipientAddress").val();
  messagetitle = $("#MessageTitle").val();
  messagecontents = $("#MessageContent").val();
  contractInstance.SendNewMessage(msg.sender,useraddress,messagetitle,messagecontents,true {from: web3.eth.accounts[0]}, function() {
    
    $("#" + div_id).html(contractInstance.totalVotesFor.call(candidateName).toString());
  });
}

function NormalSendMessage() {
  useraddress = $("#RecipientAddress").val();
  messagetitle = $("#MessageTitle").val();
  messagecontents = $("#MessageContent").val();
  contractInstance.SendNewMessage(msg.sender,useraddress,messagetitle,messagecontents,false {from: web3.eth.accounts[0]}, function() {
    
    $("#ConfirmationMessage").html();
  });
}

$(document).ready(function() {
  candidateNames = Object.keys(candidates);
  for (var i = 0; i < candidateNames.length; i++) {
    let name = candidateNames[i];
    let val = contractInstance.totalVotesFor.call(name).toString()
    $("#" + candidates[name]).html(val);
  }
});