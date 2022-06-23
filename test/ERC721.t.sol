// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/ERC721.sol";

contract ContractTest is Test {
    ERC721  erc721;
    address blessing = address(0x1);
    address rex = address(0x2);

    function testMintToken() public {
        erc721 = new ERC721();
        erc721.mint(blessing, 0);
        address owner_of = erc721.ownerOf(0);
        assertEq(blessing, owner_of);
    }

    function testTransferToken() public {
        erc721 = new ERC721();
        erc721.mint(blessing, 0);

        vm.startPrank(blessing);
        erc721.safeTransferFrom(blessing, rex, 0);

        address owner_of = erc721.ownerOf(0);
        assertEq(rex, owner_of);
    }

    function testGetBalance() public {
        erc721 = new ERC721();
         erc721.mint(blessing, 0);
         erc721.mint(blessing, 1);
         erc721.mint(blessing, 2);
         erc721.mint(blessing, 3);
         erc721.mint(blessing, 4);

         uint balance = erc721.balanceOf(blessing);
         assertEq(balance, 5);
    }

    function testOnlyOwnerBurn() public {
        erc721 = new ERC721();
        erc721.mint(blessing, 0);
        vm.startPrank(rex);
        vm.expectRevert("not owner of token");
        erc721.burn(0);
        emit log_address(rex);
    }

}