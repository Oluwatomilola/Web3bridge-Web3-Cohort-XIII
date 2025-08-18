import { ethers } from "hardhat";
import { IERC20 } from "../typechain-types";
const helpers = require("@nomicfoundation/hardhat-toolbox/network-helpers");

const main = async () => {
  const USDCAddress = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
  const DAIAddress = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
  const wethAddress = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";

  const UNIRouter = "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D";
  const FACTORY = await ethers.getContractAt(
    "IUniswapV2Factory",
    await (await ethers.getContractAt("IUniswapV2Router02", UNIRouter)).factory()
  );

  const USDCHolder = "0xf584f8728b874a6a5c7a8d4d387c9aae9172d621";

  await helpers.impersonateAccount(USDCHolder);
  const impersonatedSigner = await ethers.getSigner(USDCHolder);

  const USDC = await ethers.getContractAt("IERC20", USDCAddress) as unknown as IERC20;
  const DAI = await ethers.getContractAt("IERC20", DAIAddress) as unknown as IERC20;
  const WETH = await ethers.getContractAt("IERC20", wethAddress) as unknown as IERC20;
  const ROUTER = await ethers.getContractAt("IUniswapV2Router02", UNIRouter);

  const amountIn = ethers.parseUnits("100", 6);
  const amountOutMin = ethers.parseUnits("90", 18);
  const amountOut = ethers.parseUnits("100", 18);
  const amountInMax = ethers.parseUnits("110", 6);
  const deadline = Math.floor(Date.now() / 1000) + 60 * 10;

  /** -------------------- TOKEN APPROVALS -------------------- **/
  console.log("Approving USDC & DAI for Uniswap...");
  await (await USDC.connect(impersonatedSigner).approve(UNIRouter, amountInMax)).wait();
  await (await DAI.connect(impersonatedSigner).approve(UNIRouter, amountInMax)).wait();
  console.log("Approval successful!");

  /** -------------------- SWAP FUNCTIONS -------------------- **/
  console.log("Executing swaps...");

  await (await ROUTER.connect(impersonatedSigner).swapExactTokensForTokens(amountIn, amountOutMin, [USDCAddress, DAIAddress], impersonatedSigner.address, deadline)).wait();
  console.log("swapExactTokensForTokens executed!");

  await (await ROUTER.connect(impersonatedSigner).swapTokensForExactTokens(amountOut, amountInMax, [USDCAddress, DAIAddress], impersonatedSigner.address, deadline)).wait();
  console.log("swapTokensForExactTokens executed!");

  await (await ROUTER.connect(impersonatedSigner).swapExactETHForTokens(amountOutMin, [wethAddress, USDCAddress], impersonatedSigner.address, deadline, { value: ethers.parseEther("1") })).wait();
  console.log("swapExactETHForTokens executed!");

  await (await ROUTER.connect(impersonatedSigner).swapTokensForExactETH(amountOut, amountInMax, [USDCAddress, wethAddress], impersonatedSigner.address, deadline)).wait();
  console.log("swapTokensForExactETH executed!");

  await (await ROUTER.connect(impersonatedSigner).swapExactTokensForETH(amountIn, amountOutMin, [USDCAddress, wethAddress], impersonatedSigner.address, deadline)).wait();
  console.log("swapExactTokensForETH executed!");

  await (await ROUTER.connect(impersonatedSigner).swapETHForExactTokens(amountOut, [wethAddress, DAIAddress], impersonatedSigner.address, deadline, { value: ethers.parseEther("1") })).wait();
  console.log("swapETHForExactTokens executed!");

  /** -------------------- LIQUIDITY FUNCTIONS -------------------- **/
  console.log("Adding & Removing Liquidity...");

  await (await ROUTER.connect(impersonatedSigner).addLiquidity(USDCAddress, DAIAddress, amountIn, amountOut, 0, 0, impersonatedSigner.address, deadline)).wait();
  console.log("addLiquidity executed!");

  await (await ROUTER.connect(impersonatedSigner).addLiquidityETH(DAIAddress, amountIn, 0, 0, impersonatedSigner.address, deadline, { value: ethers.parseEther("1") })).wait();
  console.log("addLiquidityETH executed!");

  const pairAddress = await FACTORY.getPair(USDCAddress, DAIAddress);
  const LPToken = await ethers.getContractAt("IERC20", pairAddress);
  const lpBalance = await LPToken.balanceOf(impersonatedSigner.address);

  await (await ROUTER.connect(impersonatedSigner).removeLiquidity(USDCAddress, DAIAddress, lpBalance, 0, 0, impersonatedSigner.address, deadline)).wait();
  console.log("removeLiquidity executed!");

  await (await ROUTER.connect(impersonatedSigner).removeLiquidityETH(DAIAddress, lpBalance, 0, 0, impersonatedSigner.address, deadline)).wait();
  console.log("removeLiquidityETH executed!");

  /** -------------------- PERMIT FUNCTIONS -------------------- **/
  console.log("Executing Permit Liquidity Removals...");

  const { v, r, s } = await impersonatedSigner.signMessage("Permit message");
  await (await ROUTER.connect(impersonatedSigner).removeLiquidityWithPermit(USDCAddress, DAIAddress, lpBalance, 0, 0, impersonatedSigner.address, deadline, true, v, r, s)).wait();
  console.log("removeLiquidityWithPermit executed!");

  await (await ROUTER.connect(impersonatedSigner).removeLiquidityETHWithPermit(DAIAddress, lpBalance, 0, 0, impersonatedSigner.address, deadline, true, v, r, s)).wait();
  console.log("removeLiquidityETHWithPermit executed!");

  /** -------------------- FEE-ON-TRANSFER FUNCTIONS -------------------- **/
  console.log("Executing Fee-On-Transfer Swaps...");

  await (await ROUTER.connect(impersonatedSigner).swapExactTokensForTokensSupportingFeeOnTransferTokens(amountIn, amountOutMin, [USDCAddress, DAIAddress], impersonatedSigner.address, deadline)).wait();
  console.log("swapExactTokensForTokensSupportingFeeOnTransferTokens executed!");

  await (await ROUTER.connect(impersonatedSigner).swapExactETHForTokensSupportingFeeOnTransferTokens(amountOutMin, [wethAddress, USDCAddress], impersonatedSigner.address, deadline, { value: ethers.parseEther("1") })).wait();
  console.log("swapExactETHForTokensSupportingFeeOnTransferTokens executed!");

  await (await ROUTER.connect(impersonatedSigner).swapExactTokensForETHSupportingFeeOnTransferTokens(amountIn, amountOutMin, [USDCAddress, wethAddress], impersonatedSigner.address, deadline)).wait();
  console.log("swapExactTokensForETHSupportingFeeOnTransferTokens executed!");

  /** -------------------- FINAL UTILITY CHECKS -------------------- **/
  console.log("Fetching Factory & WETH address...");
  const factoryAddress = await ROUTER.factory();
  const weth = await ROUTER.WETH();
  console.log("Factory Address:", factoryAddress);
  console.log("WETH Address:", weth);

  console.log("✅ All transactions executed successfully!");
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});