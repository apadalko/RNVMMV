import { NativeModules,NativeEventEmitter } from 'react-native';
var BatchedBridge = require('BatchedBridge');
import blackBox from './BlackBox'

const SwitchType = {
  PUSH : 0,
  PRESENT: 1,
  ROOT : 2
};


class Scene {
  constructor(routeName,viewModel,rootComponentName) {
    this.routeName = routeName;
    this.viewModel = viewModel;
    this.rootComponentName = rootComponentName;
  }
}

class NativeObject {
  constructor(className,properties) {
    this["~className"]=className;
    this.properties = properties;
  }
}


class Route {
  constructor(viewModelClass,rootComponentName){
    this.viewModelClass = viewModelClass;
    this.rootComponentName = rootComponentName;
  }

}
class Router {
  constructor() {
    this.routes = {};
    this.nativeRouter = NativeModules.RNRouter;
    this.unresolvedRoutes = {}
    this.logicFunction = null;
  }


  registerPathLogic(logicFunction){
    this.logicFunction = logicFunction;
    //TODO verify if available to use logic;
  }


   deadlock(){
     let initialRoute = this.logicFunction();
     if (initialRoute) {
       let scene = this.resolveRoute(initialRoute,null,null);
       this.nativeRouter.didReciveRootScene(scene);
      //  router.resolveRoute(initialRoute,null,null,(scene)=>{
      //    console.log("FINISH with logc");
       //
      //    console.log(scene);
      //    this.nativeRouter.didReciveRootScene(scene);
      //  });
     }else{
       //trhow error
     }
   }



  registerRoute(routeName,route) {
    this.routes[routeName]=route;
  }



  resolveRoute(routeName,parentViewModel,properties,callBack) {

    console.log('resolving route: '+routeName);
    var route = this.routes[routeName];
    let indif = routeName+"_"+route.viewModelClass.name+"_"+blackBox.generateViewModelTag();
    var viewModel = new route.viewModelClass(indif);
    blackBox.addViewModel(viewModel);
    console.log('did create view model: '+route.viewModelClass.name+' with indif: '+viewModel.indentifier +"ROOT COM:"+route.rootComponentName);

    return new Scene(routeName,viewModel,route.rootComponentName);

    console.log('resolving route on native side with vm, expecting viewcontroller');
    var unresolvedRoute =  {
      "viewModel":viewModel
    }
    if (callBack) {
      unresolvedRoute["callBack"]=callBack;
    }

    this.unresolvedRoutes[routeName] = unresolvedRoute
    this.nativeRouter.resolve(routeName,viewModel.indentifier,route.rootComponentName);
  }


  ///calling from native
  didResoleNativeRoute(routeName,scene){
    console.log("------------");
    console.log(scene);
    console.log("------------");

    let  unresolvedRoute =   this.unresolvedRoutes[routeName];
    if (unresolvedRoute) {
      let viewModel = unresolvedRoute["viewModel"];
      blackBox.addViewModel(viewModel);
      viewModel.didLoad();
      let callBack = unresolvedRoute["callBack"];
      if (callBack) {
        callBack(scene);
      }
      this.unresolvedRoutes[routeName] = null;
    }
  }


}


var router = new Router();
BatchedBridge.registerCallableModule(
  'RNVMMVRouter',
  router
);
module.exports = {router,Route,SwitchType,NativeObject,Scene};
// module.exports = ;
