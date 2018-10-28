//remix.ethereum.org

contract pycoin_ico {
    
    // total number of pycoin available for sale
    uint public max_pycoin = 1000000;
    
    //introducing the usd to pycoin conversion rate
    uint public usd_to_pycoin = 1000;
    
    //total number of coins bought by investors
    uint public total_pycoin_bought = 0;
    
    mapping(address => uint) equity_pycoin;
    mapping(address => uint) equity_usd;
    
    modifier can_buy_pycoin(uint usd_invested){
        require((usd_invested * usd_to_pycoin) +total_pycoin_bought <= max_pycoin);
        _;
    }
    
    function equity_in_pycoin(address investor) external view returns(uint){
        return equity_pycoin[investor];
    }
    
    function equity_in_usd(address investor) external view returns(uint){
        return equity_usd[investor];
    }
    
    //Buying pycoins
    function buy_pycoins(address investor, uint usd_invested)external
    can_buy_pycoin(usd_invested){
        uint pycoin_bought = usd_invested*usd_to_pycoin;
        equity_pycoin[investor] += pycoin_bought;
        equity_usd[investor] = equity_pycoin[investor] / usd_to_pycoin;
        total_pycoin_bought += pycoin_bought;
    }
    
    //Selling pycoins
    function sell_pycoins(address investor, uint pycoins_sold)external{
        equity_pycoin[investor] -= pycoins_sold;
        equity_usd[investor] = equity_pycoin[investor] / usd_to_pycoin;
        total_pycoin_bought -= pycoins_sold;
    }
}