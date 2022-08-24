// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AlumniSBTDrop is Ownable, ERC1155 {

    constructor() ERC1155('') {

    }

    event Attest(address indexed to, uint256[] indexed tokenId);
    event Revoke(address indexed to, uint256[] indexed tokenId);

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

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) pure override internal {
        require(from == address(0) || to == address(0), "Not allowed to transfer token");
    }

    function _afterTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) override internal {
        if (from == address(0)) {
            emit Attest(to, ids);
        } else if (to == address(0)) {
            emit Revoke(to, ids);
        }
    }

}