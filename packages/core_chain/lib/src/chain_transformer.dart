import 'package:core_chain/src/chainable.dart';
import 'package:core_chain/src/linkable_mixin.dart';

abstract class ChainTransformer<IN, OUT> with Linkable<Chainable<dynamic>> {
  OUT? transform(IN inParam);
}
