pragma solidity 0.5.17;

contract Store {
    struct Listing {
        uint256 id;
        string name;
        string description;
        uint256 price;
        address owner;
    }
    
    uint256 lastId = 0; 
    
    mapping (uint256 => Listing) public listings;
    
    event listing(uint256 id, string name, string description, uint256 price, address owner);
    
    modifier onlyListingOwner(uint256 id) {
        require(msg.sender == listings[id].owner, "You are not the owner of this listing.");
        _;
    }
    
    modifier listingMustExist(uint256 id) {
        require(id <= lastId, "That listing does not exist.");
        _;
    }
    
    function createListing(string memory name, string memory description, uint256 price) public {
        listings[lastId] = Listing(lastId, name, description, price, msg.sender);
        emit listing(lastId, name, description, price, msg.sender);
        lastId++;
    }
    
    function deleteListing(uint256 id) public listingMustExist(id) onlyListingOwner(id) {
        delete listings[id];
    }
    
    function modifyListingPrice(uint256 id, uint256 newPrice) public listingMustExist(id) onlyListingOwner(id) {
        listings[id].price = newPrice;
    }
    
}
