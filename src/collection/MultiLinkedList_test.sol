pragma solidity ^0.4.24;

import "remix_tests.sol";
import "./MultiLinkedList.sol";

contract GenAddress {
    
}

contract MultiLinkedListTest {
    MultiLinkedList mlist;
    bytes32 public fooKey = keccak256("foo");
    bytes32 public barKey = keccak256("bar");
    bytes32 public bazKey = keccak256("baz");

    function genAddress() private returns(address) {
        GenAddress gen = new GenAddress();
        return address(gen);
    }
    
    
    function beforeEach() public {
        mlist = new MultiLinkedList();
    }
    
    function initialValuesShouldBeZero() public {
        Assert.equal(mlist.count(fooKey), 0, "Foo must be zero");
        Assert.equal(mlist.count(barKey), 0, "Bar must be zero");
        Assert.equal(mlist.count(bazKey), 0, "Baz must be zero");
    }
    
    function pushingOneValue() public {
        address addr1 = genAddress();
        mlist.push(fooKey, addr1);
        
        Assert.equal(mlist.count(fooKey), 1, "Foo must be one");
        Assert.equal(mlist.count(barKey), 0, "Bar must be zero");
        Assert.equal(mlist.count(bazKey), 0, "Baz must be zero");
    }
    
    function pushingTwoValues() public {
        address addr1 = genAddress();
        address addr2 = genAddress();
        mlist.push(fooKey, addr1);
        mlist.push(fooKey, addr2);
        
        Assert.equal(mlist.count(fooKey), 2, "Foo must be two");
        Assert.equal(mlist.count(barKey), 0, "Bar must be zero");
        Assert.equal(mlist.count(bazKey), 0, "Baz must be zero");
    }
    
    function pushingMultipleValues() public {
        address addr1 = genAddress();
        address addr2 = genAddress();
        address addr3 = genAddress();
        address addr4 = genAddress();
        address addr5 = genAddress();
        
        mlist.push(fooKey, addr1);
        mlist.push(fooKey, addr2);
        mlist.push(barKey, addr3);
        mlist.push(barKey, addr4);
        mlist.push(bazKey, addr5);
        
        Assert.equal(mlist.count(fooKey), 2, "Foo must be two");
        Assert.equal(mlist.count(barKey), 2, "Bar must be two");
        Assert.equal(mlist.count(bazKey), 1, "Baz must be one");
    }
    
    function testingNthValue_1() public {
        address addr1 = genAddress();
        mlist.push(fooKey, addr1);
        
        Assert.equal(mlist.nth(fooKey, 0), addr1, "Value should be equal");
    }
    
    function testingNthValue_2() public {
        address addr1 = genAddress();
        address addr2 = genAddress();
        address addr3 = genAddress();
        address addr4 = genAddress();
        address addr5 = genAddress();
        
        mlist.push(fooKey, addr1);
        mlist.push(fooKey, addr2);
        mlist.push(barKey, addr3);
        mlist.push(barKey, addr4);
        mlist.push(bazKey, addr5);
        
        Assert.equal(mlist.nth(fooKey, 0), addr1, "Address 1 Retrieval");
        Assert.equal(mlist.nth(fooKey, 1), addr2, "Address 2 Retrieval");
        Assert.equal(mlist.nth(barKey, 0), addr3, "Address 3 Retrieval");
        Assert.equal(mlist.nth(barKey, 1), addr4, "Address 4 Retrieval");
        Assert.equal(mlist.nth(bazKey, 0), addr5, "Address 5 Retrieval");
    }
    
    function removeOneValue_1() public {
        address addr1 = genAddress();
        address addr2 = genAddress();
        mlist.push(fooKey, addr1);
        mlist.push(barKey, genAddress());
        mlist.push(fooKey, addr2);
        mlist.push(bazKey, genAddress());
        
        Assert.equal(mlist.count(fooKey), 2, "Count should be 2");
        mlist.remove(fooKey, 0);
        Assert.equal(mlist.count(fooKey), 1, "Count should be 1");
        Assert.equal(mlist.nth(fooKey, 0), addr2, "First element should now be second value");
        
        mlist.remove(fooKey, 0);
        Assert.equal(mlist.count(fooKey), 0, "Count should be 0");
        
        mlist.push(fooKey, addr1);
        mlist.push(fooKey, addr2);
        Assert.equal(mlist.count(fooKey), 2, "Count should be 2");
        Assert.equal(mlist.nth(fooKey, 0), addr1, "Value should be address 1");
        Assert.equal(mlist.nth(fooKey, 1), addr2, "Value should be address 2");
        
    }
    
    function removeOneValue_2() public {
        address addr1 = genAddress();
        address addr2 = genAddress();
        mlist.push(fooKey, addr1);
        mlist.push(barKey, genAddress());
        mlist.push(fooKey, addr2);
        mlist.push(bazKey, genAddress());
        
        Assert.equal(mlist.count(fooKey), 2, "Count should be 2");
        mlist.remove(fooKey, 0);
        Assert.equal(mlist.count(fooKey), 1, "Count should be 1");
        Assert.equal(mlist.firstValue(fooKey), addr2, "First element should now be second value");
        
        mlist.remove(fooKey, 0);
        Assert.equal(mlist.count(fooKey), 0, "Count should be 0");
        
        mlist.push(fooKey, addr1);
        mlist.push(fooKey, addr2);
        Assert.equal(mlist.count(fooKey), 2, "Count should be 2");
        Assert.equal(mlist.firstValue(fooKey), addr1, "Value should be address 1");
        Assert.equal(mlist.secondValue(fooKey), addr2, "Value should be address 2");
        
    }
    
}
