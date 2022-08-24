// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AlumniNFTDrop is Ownable, ERC1155 {

    constructor() ERC1155('') {

    }

    function mint(address to, uint256 tokenId, bytes memory data) onlyOwner public {
        require(balanceOf(to, tokenId) == 0, "NFTDrop: address can't receive multiple drops");
        _mint(to, tokenId, 1, data);
    }

    function batchMint(address[] memory to, uint256[] memory tokenIds, bytes memory data) onlyOwner public {
        require(to.length == tokenIds.length, "ERC1155: ids and recipient lengths do not match");
        for (uint256 i = 0; i < to.length; i++) {
            mint(to[i], tokenIds[i], data);
        }
    }
}