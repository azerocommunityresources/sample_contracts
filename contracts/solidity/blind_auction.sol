// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract EnglishAuction {
    // Parameters of auction. 
    // Either time is in YYYY-MM-DD
    // or time periods in seconds

    address payable public beneficiary;
    uint public auctionEndTime;

    // Idea: This is a sample implementation of english auction
    // In english auction, the bid starts with some minimum threshold
    // and then the winner bid takes it all

    // store the bid, address and amount
    address public highestBidder;
    uint public highestBid;

    // Allow withdrawals from previous bid
    mapping(address => unit) pendingReturns;

    // flag to address the state of the auction
    bool ended;

    // Events that will be emitted on changes
    event HighestBidIncresed(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    // errors to describe failures
    error AuctionAlreadyEnded();
    error BidNotHighEnough();
    error AuctionNotYetEnded();
    error AuctionEndAlreadyCalled();

    // constructor
    constructor(
        uint biddingTime,
        address payable beneficiaryAddress
    ) {
        beneficiary = beneficiaryAddress;
        // imp: the auction time also work from the starting point of block time
        auctionEndTime = block.timestamp + biddingTime;
    }

    // bid on the auction with the value send
    function bid() external payable {
        if (block.timestamp > auctionEndTime)
            revert AuctionAlreadyEnded();
        
        if (msg.value <= highestBid)
            revert BidNotHighEnough(highestBid);
        
        if (highestBid != 0) {
            // if it is not the highest bid
            // add it to the pendingReturns
            // because if the auction does not go through 
            // send it back
            pendingReturns[highestBidder] = highestBid
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncresed(msg.sender, msg.value);
    }

    // withdraw the bid when the bid is over
    function withdraw() external returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // first remove the amount from pending list
            pendingReturns[msg.sender] = 0;
            // send the amount
            if (!payable(msg.sender).send(amount)) {
                // if it did not go through, pass it again
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    function auctionEnd() external {
        // check the condition
        if (block.timestamp < auctionEndTime)
            revert AuctionNotYetEnded()
        
        if (ended)
            revert AuctionEndAlreadyCalled();
        
        // effects
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // interaction
        beneficiary.transfer(highestBid);

    }
}