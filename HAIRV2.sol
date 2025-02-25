
// File: @openzeppelin/contracts@4.5.0/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts@4.5.0/utils/Context.sol


// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts@4.5.0/access/Ownable.sol


// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)

pragma solidity ^0.8.0;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts@4.5.0/security/ReentrancyGuard.sol


// OpenZeppelin Contracts v4.4.1 (security/ReentrancyGuard.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

// File: @uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol

pragma solidity >=0.6.2;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

// File: @uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol

pragma solidity >=0.6.2;


interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

// File: @uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol

pragma solidity >=0.5.0;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

// File: tim333.sol


pragma solidity ^0.8.20;






contract HairOfTrump is IERC20, Ownable, ReentrancyGuard {
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => bool) private _isExcludedFromFee;

    address[] public path;


    address payable private _marketingWallet;
    address payable private _launchMarketingWallet;
    uint256 public _marketingWalletPercentage = 50;
    uint256 public _launchMarketingPercentage = 50;

    uint256 private firstBlock;

    uint256 public buyTax;
    uint256 public sellTax;

    uint8 private constant _decimals = 9;
    uint256 private constant _tTotal = 100000000 * 10**_decimals;
    string private constant _name = unicode"Mayor of PUMP";
    string private constant _symbol = unicode"MAYOROFPUMP";
    uint256 public _maxTxAmount = 2000000 * 10**_decimals;
    uint256 public _maxWalletSize = 2000000 * 10**_decimals;
    uint256 public _taxSwapThreshold = 50000 * 10**_decimals;
    uint256 public _maxTaxSwap = 1000000 * 10**_decimals;

    IUniswapV2Router02 private uniswapV2Router;
    address private uniswapV2Pair;
    bool private tradingOpen = false;
    bool private inSwap = false;
    bool private swapEnabled = false;

    event ClearStuck(uint256 amount);
    event ClearToken(address TokenAddressCleared, uint256 Amount);
    event TradingOpened(uint256 timestamp);
    event AirdropExecuted(address indexed executor, uint256 totalAirdropped);
    event BuyTaxUpdated(uint256 newBuyTax);
    event SellTaxUpdated(uint256 newSellTax);
    event TaxApplied(address indexed from, address indexed to, uint256 amount, uint256 taxAmount, string taxType);

    modifier lockTheSwap {
        inSwap = true;
        _;
        inSwap = false;
    }

    constructor (
        address initialOwner,
        address marketingWallet,
        address launchMarketingWallet
    ) {
        require(initialOwner != address(0), "Initial owner cannot be zero address");
        require(marketingWallet != address(0), "Marketing wallet cannot be zero address");
        require(launchMarketingWallet != address(0), "Launch marketing wallet cannot be zero address");

        _transferOwnership(initialOwner);

        _balances[initialOwner] = _tTotal;

        _marketingWallet = payable(marketingWallet);
        _launchMarketingWallet = payable(launchMarketingWallet);

        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[_marketingWallet] = true;
        _isExcludedFromFee[_launchMarketingWallet] = true;

        buyTax = 20; // Initial buy tax
        sellTax = 20; // Initial sell tax

        emit Transfer(address(0), initialOwner, _tTotal);
    }

    function name() public pure  returns (string memory) {
        return _name;
    }

    function symbol() public pure  returns (string memory) {
        return _symbol;
    }

    function decimals() public pure  returns (uint8) {
        return _decimals;
    }

    function totalSupply() public pure override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address ownerAddr, address spender) public view override returns (uint256) {
        return _allowances[ownerAddr][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()] - amount);
        return true;
    }

    function _approve(address ownerAddr, address spender, uint256 amount) private {
        require(ownerAddr != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[ownerAddr][spender] = amount;
        emit Approval(ownerAddr, spender, amount);
    }

    function _transfer(address from, address to, uint256 amount) private {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");

        uint256 taxAmount = 0;
        if (from != owner() && to != owner()) {
            if(from != address(this)) {
                require(tradingOpen, "Trading not enabled");
            }

            if (from == uniswapV2Pair && to != address(uniswapV2Router) && !_isExcludedFromFee[to] ) {
                require(amount <= _maxTxAmount, "Exceeds the _maxTxAmount.");
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the maxWalletSize.");
                taxAmount = (amount * buyTax) / 100;
            }

            if (to != uniswapV2Pair && !_isExcludedFromFee[to]) {
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the maxWalletSize.");
            }

            if(to == uniswapV2Pair && from != address(this) ){
                taxAmount = (amount * sellTax) / 100;
            }

            uint256 contractTokenBalance = balanceOf(address(this));
            if (!inSwap && to == uniswapV2Pair && swapEnabled && contractTokenBalance > _taxSwapThreshold) {
                swapTokensForEth(_min(amount, _min(contractTokenBalance, _maxTaxSwap)));
                uint256 contractETHBalance = address(this).balance;
                if(contractETHBalance > 0) {
                    sendETHToFee(contractETHBalance);
                }
            }
        }

        if(taxAmount > 0) {
            _balances[address(this)] += taxAmount;
            emit Transfer(from, address(this), taxAmount);

            // Determine tax type for the event
            string memory taxType = from == uniswapV2Pair ? "Buy" : to == uniswapV2Pair ? "Sell" : "Other";
            emit TaxApplied(from, to, amount, taxAmount, taxType);
        }
        _balances[from] -= amount;
        _balances[to] += (amount - taxAmount);
        emit Transfer(from, to, amount - taxAmount);
    }

    function _min(uint256 a, uint256 b) private pure returns (uint256) {
        return (a > b) ? b : a;
    }



    function swapTokensForEth(uint256 tokenAmount) private lockTheSwap nonReentrant {
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        _approve(address(this), address(uniswapV2Router), tokenAmount);
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }

    function removeLimits() external onlyOwner nonReentrant {
        _maxTxAmount = _tTotal;
        _maxWalletSize = _tTotal;
    }

    function initialReduceLMFee() external onlyOwner nonReentrant {
        _launchMarketingPercentage = 34;
        _marketingWalletPercentage = 66;
        buyTax = 2; // Set buy tax to final buy tax
        sellTax = 3; // Set sell tax to final sell tax

        emit BuyTaxUpdated(buyTax);
        emit SellTaxUpdated(sellTax);
    }

    function reduceHalfLMFee() external onlyOwner nonReentrant {
        _launchMarketingPercentage = 17;
        _marketingWalletPercentage = 83;
    }

    function removeLMFee() external onlyOwner nonReentrant {
        _launchMarketingPercentage = 0;
        _marketingWalletPercentage = 100;
    }

    function sendETHToFee(uint256 amount) private nonReentrant {
        uint256 marketingWalletShare = (amount * _marketingWalletPercentage) / 100;
        uint256 launchWalletShare = (amount * _launchMarketingPercentage) / 100;
        _marketingWallet.transfer(marketingWalletShare);
        _launchMarketingWallet.transfer(launchWalletShare);
    }

    function clearStuckToken(address tokenAddress, uint256 tokens) external onlyOwner nonReentrant returns (bool success) {
        require(tokenAddress != address(this), "Can't rescue Project Token");
        if(tokens == 0){
            tokens = IERC20(tokenAddress).balanceOf(address(this));
        }
        emit ClearToken(tokenAddress, tokens);
        return IERC20(tokenAddress).transfer(_marketingWallet, tokens);
    }

    function manualSend() external onlyOwner nonReentrant {
        require(address(this).balance > 0, "Contract balance must be greater than zero");
        uint256 balance = address(this).balance;
        _marketingWallet.transfer(balance);
    }

    function manualSwap() external onlyOwner nonReentrant {
        uint256 tokenBalance = balanceOf(address(this));
        if(tokenBalance > 0 && tokenBalance > _taxSwapThreshold){
            swapTokensForEth(_taxSwapThreshold);
        }
        else if(tokenBalance > 0 && tokenBalance < _taxSwapThreshold){
            swapTokensForEth(tokenBalance);
        }
        uint256 ethBalance = address(this).balance;
        if(ethBalance > 0){
            sendETHToFee(ethBalance);
        }
    }

    function openTrading() external onlyOwner nonReentrant {
        require(!tradingOpen, "Trading is already open");

        // Initialize Uniswap Router
        // Replace with the correct router address for your deployment network
        uniswapV2Router = IUniswapV2Router02(0xeeabd314e2eE640B1aca3B27808972B05c7f6A3b);
        // uniswapV2Router = IUniswapV2Router02(0x8cFe327CEc66d1C090Dd72bd0FF11d690C33a2Eb); //base

        // Create the pair
        uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this), uniswapV2Router.WETH());

        // Enable trading
        tradingOpen = true;
        swapEnabled = true;
        firstBlock = block.number;

        emit TradingOpened(block.timestamp);
    }

    /**
     * @notice Airdrops tokens to multiple wallets.
     * @param airdropWallets Array of wallet addresses to receive tokens.
     * @param amount Array of token amounts corresponding to each wallet.
     */
    function airdropToWallets(
        address[] memory airdropWallets,
        uint256[] memory amount
    ) external onlyOwner nonReentrant {
        require(airdropWallets.length == amount.length, "Arrays must be the same length");
        require(airdropWallets.length <= 200, "Wallets list length must be <= 200");

        uint256 totalAirdropped = 0;

        for (uint256 i = 0; i < airdropWallets.length; i++) {
            address wallet = airdropWallets[i];
            uint256 airdropAmount = amount[i] * (10**_decimals);
            require(balanceOf(msg.sender) >= airdropAmount, "Not Enough Tokens To Airdrop");
            _transfer(msg.sender, wallet, airdropAmount);
            totalAirdropped += airdropAmount;
        }

        emit AirdropExecuted(msg.sender, totalAirdropped);
    }


    /**
     * @notice Returns the current buy tax.
     * @return Current buy tax percentage.
     */
    function currentBuyTax() external view returns (uint256) {
        return buyTax;
    }

    /**
     * @notice Returns the current sell tax.
     * @return Current sell tax percentage.
     */
    function currentSellTax() external view returns (uint256) {
        return sellTax;
    }

    /**
     * @notice Returns the Uniswap V2 pair address for this token.
     * @return Uniswap V2 pair address.
     */
    function getUniswapV2Pair() external view returns (address) {
        return uniswapV2Pair;
    }

    /**
     * @notice Checks if trading is currently enabled.
     * @return True if trading is enabled, false otherwise.
     */
    function isTradingEnabled() external view returns (bool) {
        return tradingOpen;
    }

    receive() external payable {}
}

// File: tim333Factory.sol


pragma solidity ^0.8.20;


contract HairOfTrumpFactory {
    event ContractDeployed(address indexed owner, address indexed contractAddress);

    address[] public deployedContracts;
    mapping(address => address[]) public ownerContracts;

    /**
     * @notice Deploys a new HairOfTrump token contract.
     * @param marketingWallet The address of the marketing wallet.
     * @param launchMarketingWallet The address of the launch marketing wallet.
     * @return The address of the newly deployed HairOfTrump contract.
     */
    function deployToken(address marketingWallet, address launchMarketingWallet) external returns (address) {
        HairOfTrump newToken = new HairOfTrump(msg.sender, marketingWallet, launchMarketingWallet);
        address newTokenAddress = address(newToken);

        deployedContracts.push(newTokenAddress);
        ownerContracts[msg.sender].push(newTokenAddress);

        emit ContractDeployed(msg.sender, newTokenAddress);

        return newTokenAddress;
    }

    /**
     * @notice Returns all deployed HairOfTrump contracts.
     * @return An array of deployed contract addresses.
     */
    function getDeployedContracts() external view returns (address[] memory) {
        return deployedContracts;
    }

    /**
     * @notice Returns all HairOfTrump contracts deployed by a specific owner.
     * @param owner The address of the owner.
     * @return An array of contract addresses deployed by the owner.
     */
    function getContractsByOwner(address owner) external view returns (address[] memory) {
        return ownerContracts[owner];
    }
}
