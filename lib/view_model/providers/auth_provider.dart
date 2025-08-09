import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> initialize() async {
    _user = _auth.currentUser;
    notifyListeners();
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _setLoading(true);
      _clearError();

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = credential.user;
      log('User signed in: ${_user?.email}');
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred. Please try again.');
      log('Sign in error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      _setLoading(true);
      _clearError();

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = credential.user;

      // Update user profile
      await _user?.updateDisplayName(fullName);

      // Create user document in Firestore
      if (_user != null) {
        await _createUserDocument(_user!, fullName);
      }

      log('User created: ${_user?.email}');
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred. Please try again.');
      log('Sign up error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      log('User signed out');
    } catch (e) {
      log('Sign out error: $e');
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      _setLoading(true);
      _clearError();

      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred. Please try again.');
      log('Reset password error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _createUserDocument(User user, String fullName) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'fullName': fullName,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      log('Error creating user document: $e');
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        _setError('No user found with this email address.');
        break;
      case 'wrong-password':
        _setError('Incorrect password. Please try again.');
        break;
      case 'email-already-in-use':
        _setError('An account already exists with this email address.');
        break;
      case 'weak-password':
        _setError('Password is too weak. Please choose a stronger password.');
        break;
      case 'invalid-email':
        _setError('Please enter a valid email address.');
        break;
      case 'too-many-requests':
        _setError('Too many failed attempts. Please try again later.');
        break;
      default:
        _setError('Authentication failed. Please try again.');
        break;
    }
    log('FirebaseAuth error: ${e.code} - ${e.message}');
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
