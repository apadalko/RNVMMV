/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

 // import ATest from 'rn_vmmv'
 import React, { Component } from 'react';
 import {
   BatchedBridge,
   AppRegistry,
   StyleSheet,
   Text,
   View
 } from 'react-native';



import {router,Route} from './rn_vmmv/router'
import coreViewModelClass from './rn_vmmv/ViewModel'


class SignInViewModel extends coreViewModelClass {
}

class WelcomeViewModel extends coreViewModelClass {
  // constructor(a){
  //   super(a);
  // }
  didLoad(){
    super.didLoad();
    console.log("lalalalal");

    setTimeout(()=>{
      console.log("11111111111");
      // this.switch('sign_in',null,SwitchType.PUSH,true);
    },3000)
  }
  goToSignIn(a,b){
    console.log("SIGN INNNNNNN first: "+a+" s :"+b);
    this.push('welcome')
  }
  loadSomeShit(a,b,callBack){
    console.log("loadSomeShit first: "+a+" s :"+b+" callback:"+callBack);
    this.throw("loadSomeShitResponse",{"a":"asas"})


  }
}
console.log(router)




export default class Gabbermap extends Component {
  render() {

      console.log(this.props);
    console.log("RENDERRRRRR");
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to RNVMMV Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({

  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(52, 52, 52, 0)',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('Gabbermap', () => Gabbermap);

router.registerRoute('welcome',new Route(WelcomeViewModel,'Gabbermap'));
router.registerRoute('sign_in',new Route(SignInViewModel,'Gabbermap'));

//
router.registerPathLogic(()=>{
  return 'welcome';
})
