// SPDX-License-Identifier: WTFPL

pragma solidity 0.8.12;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./BaseERC721IDO.sol";

interface IERC721Mintable {
    function mint(address to, uint256 tokenId) external;
}

/**
 * @notice In this IDO, the `asset` *MUST* conform to `IERC721` and `IERC721Mintable` for offering via  minting.
 */
abstract contract BaseERC721MintableIDO is BaseERC721IDO {
    constructor(address _owner, Config memory config) BaseERC721IDO(_owner, config) {
        // Empty
    }

    /**
     * @notice Mints `asset`s of `tokenIds` to `to` address. Parameter `amounts` is ignored.
     */
    function _offerAssets(
        address to,
        uint256[] memory tokenIds,
        uint256[] memory
    ) internal override {
        for (uint256 i; i < tokenIds.length; i++) {
            IERC721Mintable(asset).mint(to, tokenIds[i]);
        }
    }

    function _returnAssets(uint256[] memory) internal virtual override {
        // Empty
    }
}
