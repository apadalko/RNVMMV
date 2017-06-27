import {router,Route,NativeObject,SwitchType} from './router'
import blackBox from './BlackBox'

class ViewModel {
  constructor(indentifier){
    console.log("VIEW MODEL constructor: "+indentifier);
    this.indentifier = indentifier;
    console.log("BBOOOOX "+blackBox);

  }
  didLoad(){
    console.log("DID LOAD VIEWMODEL");

  }

  ///
  present(routeName,properties,animated = true){

  }
  push(routeName,properties,animated = true){
    console.log('PUUUUSH TO '+routeName);
    let scene = router.resolveRoute(routeName,this,properties)
    blackBox.throw(this,'switchPack',new NativeObject('RNVMMVSwitchPack',{"scene":scene,type:0}));

  }
  throw(key,value) {
    blackBox.throw(this,key,value);

  }
  pop(animated = true){

  }
  dismiss(animated = true){

  }

}

module.exports=ViewModel;
