import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const vendorsCollection = "vendors";
const productsCollection = "products";
const messagesCollection = "messages";
const chatsCollection = "chats";
const ordersCollection = "orders";
