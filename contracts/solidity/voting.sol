// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0
/// @title Voting with delegation
contract Ballot {
    // Define a structure of type Voter
    // Each voter will have an address
    // a vote -> person the voter votes for
    
    struct Voter {
        uint weight; // weight is accummulated by delegation or nomination
        bool voted; // if true the person has already voted
        address delegate; // person delegated to
        uint vote; // index of the voted proposal
    }

    // This is a type of single proposal
    struct Proposal {
        bytes32 name; // short name
        uint voteCount; // number of accumulated votes
    }

    // the initiating address or msg.sender would also be the chairperson
    // this will also be publicly vision address
    address public chairperson;

    // create a mapping from address to Voter(s)
    // This will keep a track of weight of the Voter as well as other fields with respect to the same
    // and name it voters
    // this is ~ similar to creating a hash map
    mapping(address => Voter) public voters;

    // A dynamically sized array of `Proposals`
    Proposal[] public proposals;

    /// constructor to init the values
    constructor(byter32[], memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        // for each of the person mentioned in the proposalName
        // create a new Proposal object and
        // append it to the proposals
        for (uint i =0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // voter permission and access to the contract
    function giveRightToVote(address voter) external {
        // only the chairperson or the contract itself can give the right
        // this is required as a part of security
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to Vote"
        );

        // check that there is no double voting
        require(
            !voters[voter].voted,
            "The Voter has already voted"
        );

        // check if voter weight is 0
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    // In a proper democracy, you would ideally need 
    // a way to delegate your vote to someone higher is the ranks
    // We will skip that part for now

    function vote(uint proposal) {
        Voter storage sender = voters[msg.sender]
        // check if sender has not voted yet and their vote weight is 1
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        // since this IS NOT A DELEGATED VOTING SYSTEM, the vote proposal should not have vote > 1
        // Hence increment the votepool by 1
        proposals[proposal].voteCount += 1;

    }
}