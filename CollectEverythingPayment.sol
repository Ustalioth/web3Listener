// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CollectEverything {
    event PaymentReceived(address payer, uint amount, address merchantAddress);

    uint feesPercentage = 5;
    address collectEverythingAddress = 0x41795E219A93d688bFd19d83403eAa852E291d73;

    function pay(address payable merchantAddress) public payable {
        uint amount = msg.value;

        uint merchantAmount = amount * ((100 - feesPercentage) / 100);

        transfer(merchantAddress, merchantAmount);

        uint collectEverythingAmount = address(this).balance;

        transfer(payable(collectEverythingAddress), collectEverythingAmount);

        emit PaymentReceived(msg.sender, msg.value, merchantAddress);
    }

    function transfer(address payable recipient, uint256 amount) public {
        require(address(this).balance >= amount, "Insufficient balance");
        recipient.transfer(amount);
    }
}