import 'package:core_chain/src/chain_transformer.dart';
import 'package:core_chain/src/chain_validator.dart';
import 'package:core_chain/src/linkable_mixin.dart';

class Chainable<T> with Linkable<Chainable<dynamic>> {
  Chainable._fromValue(this._value);

  final T _value;

  Chainable<OUT?> transform<OUT>(ChainTransformer<T, OUT?> transformer) {
    final prev = getPrev();
    if (prev != null) {
      transformer.prev = prev;
    }
    final next = transformer.transform(_value);
    return _toChainable(next);
  }

  Chainable<T> validate(ChainValidator<T> validator) {
    final prev = getPrev();
    if (prev != null) {
      validator.prev = prev;
    }
    final next = validator.validate(_value);
    return _toChainable(next);
  }

  Chainable<OUT> _toChainable<OUT>(OUT out) {
    final result = Chainable._fromValue(out);
    next = result;
    result.prev = this;
    return result;
  }

  T getResult() => _value;
}

class ChainPipeline {
  static Chainable<T> startWithValue<T>(T value) {
    return Chainable._fromValue(value);
  }
}
