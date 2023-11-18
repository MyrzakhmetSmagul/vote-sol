// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Voter {
    struct Candidate {
        string name;
        uint256 votes;
        bool isCandidate;
    }
    mapping(address => Candidate) candidates;
    address[] candidatesAddresses;
    mapping(address => bool) already_voted;

    function registarCandidate(string memory name) public {
        if (candidates[msg.sender].isCandidate) {
            revert("TI CANDIDATE UZHE");
        }

        candidates[msg.sender] = Candidate(name, 0, true);
        candidatesAddresses.push(msg.sender);
    }

    function vote(address voteFor) public returns (uint256) {
        isCandidate(voteFor);

        if (voteFor == msg.sender) {
            revert("TI NE MOZHESH GOLOSOVAT ZA SEBYA");
        }

        if (already_voted[msg.sender]) {
            revert("TI UZHE GOLOSOVAL BRATISHKE");
        }

        candidates[voteFor].votes++;
        already_voted[msg.sender] = true;
        return candidates[voteFor].votes;
    }

    function getVotes(address voteFor) public view returns (uint256) {
        isCandidate(voteFor);
        return candidates[voteFor].votes;
    }

    function getCandidates() public view returns (address[] memory) {
        return candidatesAddresses;
    }

    function getCandidateName(
        address candidateAddress
    ) public view returns (string memory) {
        isCandidate(candidateAddress);
        return candidates[candidateAddress].name;
    }

    function isCandidate(address candidateAddress) private view {
        if (!candidates[candidateAddress].isCandidate) {
            revert("ADDRESS NE YAVLYAETSIA CANDIDATOM");
        }
    }
}
