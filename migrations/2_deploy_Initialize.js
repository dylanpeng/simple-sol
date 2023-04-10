const Initialize = artifacts.require("Initialize");

module.exports = function(deployer) {
  deployer.deploy(Initialize);
};
