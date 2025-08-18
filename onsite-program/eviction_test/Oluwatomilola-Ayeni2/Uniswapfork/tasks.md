Add liquidity to a pool.
* get the address we want to use it's tokes/ address with the money /impersonators address
0xf584f8728b874a6a5c7a8d4d387c9aae9172d621
* use hardhat to impersonate the address
* get the uniswap router address
* get the tokens contract address


Processes to take for mainnet forking.
For now I won't be forking a block number

1. Setup the project enviroment
2. Configure my Hardhat network to Hardhat forking
3. Get my impersonation addresses available
4. My RPC url should be in the env file, make sure to install dotenv and add .env to .gitignore
5. Setup my ERC20 Interface (because we need to interact with ERC20 functions.)
6. Setup the Uniswap V2 interface (because we will have to interact with its functions too.)


async function main(){
Steps to provide liquidity to a pool.

1. Get the whale address
2. Use helper function to set it for impersonation
3. Sign the address using getSigner
4. Get the Contract address of the tokens I want to provide as liquidty
5. Get the uniswap V2 router address
6. Get access to the tokens ERC20 functions
7. I can try outputing their balances
8. Get access to Uniswap V2 Router contract functions
9. Pass in the amount i want to provide as liquidity
10. Connect to the impersonated account and approve the Router and Amount transaction
}

main().catch((e)=>{
    console.error(e);
    process.exitcode = 1;
})

<!--  0xAE461cA67B15dc8dc81CE7615e0320dA1A9aB8D5 -->













Swap tokens to tokens
