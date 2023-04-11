const Initialize = artifacts.require("Initialize");
const Account = artifacts.require("Account");

module.exports = function(deployer) {
  deployer.deploy(Initialize);
  deployer.deploy(Account,5);
};
