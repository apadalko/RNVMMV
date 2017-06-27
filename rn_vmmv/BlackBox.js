
import { NativeModules,NativeEventEmitter } from 'react-native';
var BatchedBridge = require('BatchedBridge');

class BlackBox {


  constructor(){
    this.tagCounter = 0;
    this.viewModels={};
    this.nativeBlackBox = NativeModules.RNBlackBox;
  }
  addViewModel(viewModel){
    this.viewModels[viewModel.indentifier]=viewModel;
  }
  ///
  throw(fromViewModel,key,value){
        console.log("THROW! vm_i:"+fromViewModel.indentifier+", key:"+key+", value:"+value);
      this.nativeBlackBox.send(fromViewModel.indentifier,key,value);
  }
  ///from native
  callFunctionForViewModel(viewModelIdentifier,functionName,params,callBack){

    let viewModel = this.viewModels[viewModelIdentifier];
    if (viewModel) {
      console.log("FOUND VIEWMODEL IN BLACK BOX");
      let func = viewModel[functionName];
      if (callBack) {
              console.log("FOUND callBack:"+callBack);
        var newParams = Array.from(params);
        newParams.push(callBack)
        func.apply(viewModel, newParams);
      }else{
        func.apply(viewModel, params);
      }

      // func(params);
    }
  }

  generateViewModelTag(){
    this.tagCounter++;
    return this.tagCounter;
  }


}

let blackBox = new BlackBox();

BatchedBridge.registerCallableModule(
  'RNVMMVBlackBox',
  blackBox
);
module.exports=blackBox;
