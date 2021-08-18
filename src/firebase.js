import {firebase} from '@firebase/app';
import '@firebase/auth';
import '@firebase/firestore';
var firebaseConfig = {
  apiKey: "AIzaSyCo8nzDJYA-Dhd4B6cIZQG1Z8sJNFdeHSo",
  authDomain: "ink-lord.firebaseapp.com",
  projectId: "ink-lord",
  storageBucket: "ink-lord.appspot.com",
  messagingSenderId: "938806437346",
  appId: "1:938806437346:web:9eb04b78a35e32b65f85bb",
  measurementId: "G-4NFKT369SN"
};

firebase.initializeApp(firebaseConfig);

export const auth = firebase.auth();
export const googleProvider = new firebase.auth.GoogleAuthProvider();

export const db = firebase.firestore();