import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_app/data/datasources/remote_data_sources/post/post_remote_data.dart';
import 'package:instagram_app/data/datasources/remote_data_sources/post/post_remote_data_impl.dart';
import 'package:instagram_app/data/datasources/remote_data_sources/user/user_remote_data.dart';
import 'package:instagram_app/data/datasources/remote_data_sources/user/user_remote_data_impl.dart';
import 'package:instagram_app/data/repositories/firebase_repository_impl.dart';
import 'package:instagram_app/domain/repository/firebase_repository.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/follow_unfollow_user_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/get_users_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/sign_out_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/sign_up_user_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/update_user_avatar_usecase.dart';
import 'package:instagram_app/domain/use_cases/firebase_usecases/user/update_user_usecase.dart';
import 'package:instagram_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_app/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_app/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_app/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_app/presentation/cubit/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Cubit instance

  sl.registerFactory(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));

  sl.registerFactory(() =>
      CredentialCubit(signInUserUseCase: sl.call(), signUpUseCase: sl.call()));

  sl.registerFactory(() => UserCubit(
      getUsersUseCase: sl.call(),
      updateUserUseCase: sl.call(),
      followUnFollowUseCase: sl.call(),
     updateUserAvatarUseCase: sl.call()
  ));

  sl.registerFactory(() => PostCubit());

  sl.registerFactory(() => GetSingleUserCubit(getSingleUserUseCase: sl.call()));

  // UseCase
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => FollowUnFollowUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserAvatarUseCase(firebaseRepository: sl.call()));

  // repository

  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImpl(
      userRemoteData: sl.call(), postRemoteData: sl.call()));

  // repository remote
  sl.registerLazySingleton<UserRemoteData>(() => UserRemoteDataImpl(
    firebaseStorage: sl.call(),
      firebaseAuth: sl.call(), firebaseFirestore: sl.call()));

  sl.registerLazySingleton<PostRemoteData>(() => PostRemoteDataImpl());

  //
  //   Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
