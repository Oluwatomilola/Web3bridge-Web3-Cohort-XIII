import { ethers } from "hardhat";
const helpers = require("@nomicfoundation/hardhat-toolbox/network-helpers");

const main = async () => {
  const USDCAddress = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
  const DAIAddress = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
  const UNIRouter = "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D";

  const USDCHolder = "0xf584f8728b874a6a5c7a8d4d387c9aae9172d621";

  console.log("Impersonating account:", USDCHolder);
  await helpers.impersonateAccount(USDCHolder);
  const impersonatedSigner = await ethers.getSigner(USDCHolder);
  console.log("Signer address:", impersonatedSigner.address);

  const USDC = await ethers.getContractAt("IERC20", USDCAddress);
  const DAI = await ethers.getContractAt("IERC20", DAIAddress);
  const ROUTER = await ethers.getContractAt("IUniswapV2Router02", UNIRouter);

  const amountIn = ethers.parseUnits("10000", 6);
  const amountOutMin = ethers.parseUnits("3", 18);
  const deadline = Math.floor(Date.now() / 1000) + 60 * 10;

  const usdcBalanceBefore = await USDC.balanceOf(impersonatedSigner.address);
  const daiBalanceBefore = await DAI.balanceOf(impersonatedSigner.address);

  console.log("USDC Balance before swap:", ethers.formatUnits(usdcBalanceBefore, 6));
  console.log("DAI Balance before swap:", ethers.formatUnits(daiBalanceBefore, 18));

  console.log("Approving Uniswap Router to spend USDC...");
  await USDC.connect(impersonatedSigner).approve(UNIRouter, amountIn);
  console.log("Approval successful!");

  console.log("Executing swap: USDC -> DAI...");
  const tx = await ROUTER.connect(impersonatedSigner).swapExactTokensForTokensSupportingFeeOnTransferTokens(
    amountIn,
    amountOutMin,
    [USDCAddress, DAIAddress],
    impersonatedSigner.address,
    deadline
  );
  await tx.wait();
  console.log("swapExactTokensForTokensSupportingFeeOnTransferTokens executed!");

  const usdcBalanceAfter = await USDC.balanceOf(impersonatedSigner.address);
  const daiBalanceAfter = await DAI.balanceOf(impersonatedSigner.address);

  console.log("USDC Balance after swap:", ethers.formatUnits(usdcBalanceAfter, 6));
  console.log("DAI Balance after swap:", ethers.formatUnits(daiBalanceAfter, 18));
};

main().catch((error) => {
  console.error("Error encountered:", error);
  process.exitCode = 1;
});
