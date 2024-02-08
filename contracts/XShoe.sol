pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract XShoesNFT is ERC721, Ownable {
    event XShoeCreated(uint256 indexed tokenId);

    string public apiBaseURL;

    constructor() public ERC721("XShoes", "Xshoe") {}

    function _baseURI() internal view override returns (string memory) {
        return apiBaseURL;
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        require(_exists(tokenId), "DNE");

        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length > 0
                ? string(
                    abi.encodePacked(baseURI, tokenID2str(tokenId), ".json")
                )
                : "";
    }

    function setAPIBaseURL(string memory url) external onlyAdmin {
        apiBaseURL = url;
    }

    function mint(uint256 _mintAmount) public payable {
        if (msg.sender != owner()) {
            require(msg.value >= cost * _mintAmount);
        }

        for (uint256 i = 1; i <= _mintAmount; i++) {
            _safeMint(msg.sender, supply + i);
        }
    }
}
