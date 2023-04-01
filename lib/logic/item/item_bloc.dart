import 'package:bloc/bloc.dart';
import 'package:thriftly/data/models/Item.dart';
import 'package:thriftly/data/providers/item_provider.dart';
import 'package:thriftly/data/repositories/item_repository.dart';
import 'package:thriftly/logic/item/item_event.dart';
import 'package:thriftly/logic/item/item_state.dart';
import 'package:thriftly/presentation/shop/widgets/item_preview.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRespositry _itemRespositry;

  ItemBloc(ItemRespositry ItemRespositry)
      : _itemRespositry = ItemRespositry,
        super(ItemInitial());

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is GetItems) {
      yield* _mapGetItemsToState(event);
    }
  }

  Stream<ItemState> _mapGetItemsToState(GetItems event) async* {
    yield ItemLoading();
    final items = await _itemRespositry.getItems();
    print(items);
    if (items != null) {
      yield ItemObtained(items: items);
    } else {
      yield ItemFailure(error: "failed to obtain items");
    }
  }
}
