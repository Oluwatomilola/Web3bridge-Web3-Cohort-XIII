import {
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("School Deployment", function () {
  async function deploySchool() {

    const School = await hre.ethers.getContractFactory("School");
    const school = await School.deploy();

    return {school};
  }

  describe("Student registration", function () {
    it("Should register a student", async function () {

      const {school} = await loadFixture(deploySchool);

      const name = "Sherif";

      const age = 12;

      await school.register_student_(name,age);

      const student_length = await school.get_students();

      const get_student_details = student_length[0];

      expect(get_student_details.name).to.equal(name);

      expect(get_student_details.age).to.equal(age);
    });
  });

  describe("Students length", function () {
      it("Should get right student length", async function () {
      const { school } = await loadFixture(deploySchool);

       const name = "Sherif";

       const age = 12;

       await school.register_student_(name,age);

      const student_length = await school.get_students();

      expect(student_length.length).to.equal(1);
    });
  });
 });
