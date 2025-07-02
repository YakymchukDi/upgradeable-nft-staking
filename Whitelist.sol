// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Whitelist is Ownable {
    mapping(address => bool) private whitelisted;

    event AddedToWhitelist(address indexed account);
    event RemovedFromWhitelist(address indexed account);

    // Добавить адрес в белый список
    function addToWhitelist(address account) external onlyOwner {
        whitelisted[account] = true;
        emit AddedToWhitelist(account);
    }

    // Удалить адрес из белого списка
    function removeFromWhitelist(address account) external onlyOwner {
        whitelisted[account] = false;
        emit RemovedFromWhitelist(account);
    }

    // Проверить, есть ли адрес в белом списке
    function isWhitelisted(address account) public view returns (bool) {
        return whitelisted[account];
    }

    // Пример функции с ограничением по белому списку
    function whitelistOnlyFunction() external view returns (string memory) {
        require(whitelisted[msg.sender], "Not in whitelist");
        return "You are whitelisted!";
    }
}
