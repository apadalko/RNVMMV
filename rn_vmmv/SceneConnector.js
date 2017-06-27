import { NativeModules,NativeEventEmitter } from 'react-native';
var BatchedBridge = require('BatchedBridge');


class SceneConnector {
  constructor() {
    this.scenes = {};
    this.nativeConnector = NativeModules.RNVMSceneConnector;
  }
  // js functions
  generateScene(sceneIdentifier,viewModel,callBack) {
    this.scenes[sceneIdentifier]={
      "viewModel":viewModel;
    }
    this.nativeConnector.loadScene(sceneIdentifier)
  }
  //native callable functions
  didCreateNativeScene(sceneIdentifier)


}
var connector = new SceneConnector();
BatchedBridge.registerCallableModule(
  'RNVMMVSceneConnector',
  connector
);
module.exports = connector;
