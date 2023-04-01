import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thriftly/data/repositories/item_listing_repository.dart';
import 'package:thriftly/helpers/firebase_functions.dart';
import 'package:thriftly/logic/exceptions/post_exception.dart';
import 'package:thriftly/logic/item_listing/item_listing_event.dart';
import 'package:thriftly/logic/item_listing/item_listing_state.dart';

class ItemListingBloc extends Bloc<ItemListingEvent, ItemListingState> {
  final ItemListingRepository _itemListingRepository;

  ItemListingBloc(ItemListingRepository itemListingRepository)
      : _itemListingRepository = itemListingRepository,
        super(ItemListingInitial());

  @override
  Stream<ItemListingState> mapEventToState(ItemListingEvent event) async* {
    if (event is CreateItemListing) {
      yield* _mapCreateItemListingToState(event);
    }

    if (event is CreateOutfitInspoEvent) {
      yield* _mapCreateOutfitInspoState(event);
    }

    // if (event is GetPosts) {
    //   yield* _mapGetPostsToState(event);
    // }

    // if (event is AcceptPost) {
    //   yield* _mapAcceptPostToState(event);
    // }

    if (event is NavigateToCreateItemListingForm) {
      yield RedirectToCreateItemListing();
    }

    if (event is NavigateToPostOutfitInspo) {
      yield RedirectToPostOutfitInspo();
    }
  }

  Stream<ItemListingState> _mapCreateItemListingToState(
      CreateItemListing event) async* {
    yield ItemListingLoading();
    print(FirebaseAuth.instance.currentUser?.uid);
    try {
      await _itemListingRepository.createItemListing(
        title: event.title,
        description: event.description,
        size: event.size,
        price: event.price,
        imageFile: event.imageFile,
        location: event.location,
        creator: await getCurrentUserFromFirebaseUser(
            FirebaseAuth.instance.currentUser),
      );
      yield ItemListingCreated();
      yield ItemListingInitial();
      print('here');
    } on ItemListingException catch (e) {
      yield PostFailure(error: e.message);
    } catch (error) {
      print(error.toString());
      yield PostFailure(error: error.toString());
    }
  }

  Stream<ItemListingState> _mapCreateOutfitInspoState(
      CreateOutfitInspoEvent event) async* {
    yield ItemListingLoading();
    print(FirebaseAuth.instance.currentUser?.uid);
    try {
      await _itemListingRepository.createOutfitInspo(
        caption: event.caption,
        imageFile: event.imageFile,
        creator: await getCurrentUserFromFirebaseUser(
            FirebaseAuth.instance.currentUser),
      );
      yield ItemListingCreated();
      yield ItemListingInitial();
      print('here');
    } on ItemListingException catch (e) {
      yield PostFailure(error: e.message);
    } catch (error) {
      print(error.toString());
      yield PostFailure(error: error.toString());
    }
  }

  // Stream<PostState> _mapGetPostsToState(GetPosts event) async* {
  //   yield PostLoading();
  //   final posts = await _postRepository.getPosts();
  //   NsksUser user = await _postRepository.getAccountDetails();
  //   if (posts != null) {
  //     yield PostsObtained(posts: posts, user: user);
  //   } else {
  //     yield PostFailure(error: 'Something very weird just happened');
  //   }
  //   try {} on PostException catch (e) {
  //     yield PostFailure(error: e.message);
  //   } catch (err) {
  //     yield PostFailure(error: err.toString());
  //   }
  // }

  // Stream<PostState> _mapAcceptPostToState(AcceptPost event) async* {
  //   yield PostLoading();
  //   try {
  //     await _postRepository.acceptPost(event.id);
  //     yield PostAccepted();
  //   } on PostException catch (e) {
  //     yield PostFailure(error: e.message);
  //   } catch (err) {
  //     yield PostFailure(error: err.toString());
  //   }
  // }
}
