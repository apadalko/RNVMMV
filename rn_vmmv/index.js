
var BatchedBridge = require('BatchedBridge');
var ATest = {

  test: function(): string {
     return {
       "hello":"as"
     }
  }
};

BatchedBridge.registerCallableModule(
  'ATest',
  ATest
);
module.exports = ATest;
