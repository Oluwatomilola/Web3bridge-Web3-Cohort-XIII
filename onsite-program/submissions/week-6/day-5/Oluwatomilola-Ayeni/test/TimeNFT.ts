import { expect } from "chai";
import { ethers } from "hardhat";
import { TimeNFT } from "../typechain-types";

describe("TimeNFT", function () {
  let timeNFT: TimeNFT;
  let owner: any;

  beforeEach(async function () {
    [owner] = await ethers.getSigners();
    const TimeNFT = await ethers.getContractFactory("TimeNFT");
    timeNFT = await TimeNFT.deploy();
    await timeNFT.waitForDeployment();
  });

  describe("Deployment", function () {
    it("Should have correct name and symbol", async function () {
      expect(await timeNFT.name()).to.equal("Time NFT");
      expect(await timeNFT.symbol()).to.equal("TME");
    });

    it("Should start token IDs from 1", async function () {
      const tx = await timeNFT.mint();
      await expect(tx)
        .to.emit(timeNFT, "Transfer")
        .withArgs(ethers.ZeroAddress, owner.address, 1);
    });
  });

  describe("Minting", function () {
    it("Should increment tokenId correctly", async function () {
      await timeNFT.mint();
      const tx = await timeNFT.mint();
      await expect(tx)
        .to.emit(timeNFT, "Transfer")
        .withArgs(ethers.ZeroAddress, owner.address, 2);
    });

    it("Should emit event with correct tokenId", async function () {
      await expect(timeNFT.mint())
        .to.emit(timeNFT, "Transfer")
        .withArgs(ethers.ZeroAddress, owner.address, 1);
    });
  });

  describe("Metadata", function () {
    it("Should return valid tokenURI", async function () {
      await timeNFT.mint();
      const uri = await timeNFT.tokenURI(1);
      expect(uri).to.include("data:application/json;base64");
    });

    it("Should include timestamp in image URL", async function () {
      await timeNFT.mint();
      const uri = await timeNFT.tokenURI(1);
      const jsonBase64 = uri.split(",")[1];
      const json = Buffer.from(jsonBase64, "base64").toString();
      const imageUrl = JSON.parse(json).image;
      expect(imageUrl).to.match(/\?t=\d+$/);
    });

    it("Should display properly formatted time in SVG", async function () {
      await timeNFT.mint();
      const uri = await timeNFT.tokenURI(1);
      const jsonBase64 = uri.split(",")[1];
      const json = Buffer.from(jsonBase64, "base64").toString();
      const svgBase64 = JSON.parse(json).image.split(",")[1].split("?")[0];
      const svg = Buffer.from(svgBase64, "base64").toString();
      
      // Verify the time format is HH:MM:SS
      expect(svg).to.match(/<text[^>]*>\d{2}:\d{2}:\d{2}<\/text>/);
    });
  });
});