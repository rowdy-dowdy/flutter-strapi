part of 'flash_sale_cubit.dart';

@immutable
abstract class FlashSaleState {
  const FlashSaleState();
}

class FlashSaleInitial extends FlashSaleState {
  const FlashSaleInitial();
}

class FlashSaleLoading extends FlashSaleState {
  const FlashSaleLoading();
}

class FlashSaleLoaded extends FlashSaleState {
  final FlashSale? FlashSale;
  const FlashSaleLoaded({this.FlashSale});
}

class FlashSaleError extends FlashSaleState {
  final String error;
  const FlashSaleError({this.error = ''});
}