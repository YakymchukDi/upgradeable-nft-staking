// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardDistributor is Ownable {
    mapping(address => uint256) public rewards;

    event RewardAdded(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 amount);

    // Владелец начисляет награды пользователям
    function addReward(address user, uint256 amount) external onlyOwner {
        rewards[user] += amount;
        emit RewardAdded(user, amount);
    }

    // Пользователь забирает свои награды
    function claimReward() external {
        uint256 amount = rewards[msg.sender];
        require(amount > 0, "No rewards to claim");
        rewards[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send reward");

        emit RewardClaimed(msg.sender, amount);
    }

    // Контракт должен принимать эфир для выплат
    receive() external payable {}
}
