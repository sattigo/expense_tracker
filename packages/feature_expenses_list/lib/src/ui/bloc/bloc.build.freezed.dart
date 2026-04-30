// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bloc.build.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseListAction {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseListAction);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListAction()';
}


}

/// @nodoc
class $ExpenseListActionCopyWith<$Res>  {
$ExpenseListActionCopyWith(ExpenseListAction _, $Res Function(ExpenseListAction) __);
}


/// Adds pattern-matching-related methods to [ExpenseListAction].
extension ExpenseListActionPatterns on ExpenseListAction {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OpenDetail value)?  openDetail,TResult Function( OpenAddExpenseForm value)?  openAddExpenseForm,TResult Function( CloseAddExpenseForm value)?  closeAddExpenseForm,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OpenDetail() when openDetail != null:
return openDetail(_that);case OpenAddExpenseForm() when openAddExpenseForm != null:
return openAddExpenseForm(_that);case CloseAddExpenseForm() when closeAddExpenseForm != null:
return closeAddExpenseForm(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OpenDetail value)  openDetail,required TResult Function( OpenAddExpenseForm value)  openAddExpenseForm,required TResult Function( CloseAddExpenseForm value)  closeAddExpenseForm,}){
final _that = this;
switch (_that) {
case OpenDetail():
return openDetail(_that);case OpenAddExpenseForm():
return openAddExpenseForm(_that);case CloseAddExpenseForm():
return closeAddExpenseForm(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OpenDetail value)?  openDetail,TResult? Function( OpenAddExpenseForm value)?  openAddExpenseForm,TResult? Function( CloseAddExpenseForm value)?  closeAddExpenseForm,}){
final _that = this;
switch (_that) {
case OpenDetail() when openDetail != null:
return openDetail(_that);case OpenAddExpenseForm() when openAddExpenseForm != null:
return openAddExpenseForm(_that);case CloseAddExpenseForm() when closeAddExpenseForm != null:
return closeAddExpenseForm(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String expenseId)?  openDetail,TResult Function()?  openAddExpenseForm,TResult Function()?  closeAddExpenseForm,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OpenDetail() when openDetail != null:
return openDetail(_that.expenseId);case OpenAddExpenseForm() when openAddExpenseForm != null:
return openAddExpenseForm();case CloseAddExpenseForm() when closeAddExpenseForm != null:
return closeAddExpenseForm();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String expenseId)  openDetail,required TResult Function()  openAddExpenseForm,required TResult Function()  closeAddExpenseForm,}) {final _that = this;
switch (_that) {
case OpenDetail():
return openDetail(_that.expenseId);case OpenAddExpenseForm():
return openAddExpenseForm();case CloseAddExpenseForm():
return closeAddExpenseForm();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String expenseId)?  openDetail,TResult? Function()?  openAddExpenseForm,TResult? Function()?  closeAddExpenseForm,}) {final _that = this;
switch (_that) {
case OpenDetail() when openDetail != null:
return openDetail(_that.expenseId);case OpenAddExpenseForm() when openAddExpenseForm != null:
return openAddExpenseForm();case CloseAddExpenseForm() when closeAddExpenseForm != null:
return closeAddExpenseForm();case _:
  return null;

}
}

}

/// @nodoc


class OpenDetail implements ExpenseListAction {
  const OpenDetail(this.expenseId);
  

 final  String expenseId;

/// Create a copy of ExpenseListAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenDetailCopyWith<OpenDetail> get copyWith => _$OpenDetailCopyWithImpl<OpenDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenDetail&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId));
}


@override
int get hashCode => Object.hash(runtimeType,expenseId);

@override
String toString() {
  return 'ExpenseListAction.openDetail(expenseId: $expenseId)';
}


}

/// @nodoc
abstract mixin class $OpenDetailCopyWith<$Res> implements $ExpenseListActionCopyWith<$Res> {
  factory $OpenDetailCopyWith(OpenDetail value, $Res Function(OpenDetail) _then) = _$OpenDetailCopyWithImpl;
@useResult
$Res call({
 String expenseId
});




}
/// @nodoc
class _$OpenDetailCopyWithImpl<$Res>
    implements $OpenDetailCopyWith<$Res> {
  _$OpenDetailCopyWithImpl(this._self, this._then);

  final OpenDetail _self;
  final $Res Function(OpenDetail) _then;

/// Create a copy of ExpenseListAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenseId = null,}) {
  return _then(OpenDetail(
null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OpenAddExpenseForm implements ExpenseListAction {
  const OpenAddExpenseForm();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAddExpenseForm);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListAction.openAddExpenseForm()';
}


}




/// @nodoc


class CloseAddExpenseForm implements ExpenseListAction {
  const CloseAddExpenseForm();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CloseAddExpenseForm);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListAction.closeAddExpenseForm()';
}


}




/// @nodoc
mixin _$ExpenseListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListEvent()';
}


}

/// @nodoc
class $ExpenseListEventCopyWith<$Res>  {
$ExpenseListEventCopyWith(ExpenseListEvent _, $Res Function(ExpenseListEvent) __);
}


/// Adds pattern-matching-related methods to [ExpenseListEvent].
extension ExpenseListEventPatterns on ExpenseListEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadExpenses value)?  load,TResult Function( AddExpense value)?  add,TResult Function( RequestAddExpense value)?  requestAddExpense,TResult Function( OpenDetailEvent value)?  openDetail,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadExpenses() when load != null:
return load(_that);case AddExpense() when add != null:
return add(_that);case RequestAddExpense() when requestAddExpense != null:
return requestAddExpense(_that);case OpenDetailEvent() when openDetail != null:
return openDetail(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadExpenses value)  load,required TResult Function( AddExpense value)  add,required TResult Function( RequestAddExpense value)  requestAddExpense,required TResult Function( OpenDetailEvent value)  openDetail,}){
final _that = this;
switch (_that) {
case LoadExpenses():
return load(_that);case AddExpense():
return add(_that);case RequestAddExpense():
return requestAddExpense(_that);case OpenDetailEvent():
return openDetail(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadExpenses value)?  load,TResult? Function( AddExpense value)?  add,TResult? Function( RequestAddExpense value)?  requestAddExpense,TResult? Function( OpenDetailEvent value)?  openDetail,}){
final _that = this;
switch (_that) {
case LoadExpenses() when load != null:
return load(_that);case AddExpense() when add != null:
return add(_that);case RequestAddExpense() when requestAddExpense != null:
return requestAddExpense(_that);case OpenDetailEvent() when openDetail != null:
return openDetail(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( Expense expense)?  add,TResult Function()?  requestAddExpense,TResult Function( String expenseId)?  openDetail,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadExpenses() when load != null:
return load();case AddExpense() when add != null:
return add(_that.expense);case RequestAddExpense() when requestAddExpense != null:
return requestAddExpense();case OpenDetailEvent() when openDetail != null:
return openDetail(_that.expenseId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( Expense expense)  add,required TResult Function()  requestAddExpense,required TResult Function( String expenseId)  openDetail,}) {final _that = this;
switch (_that) {
case LoadExpenses():
return load();case AddExpense():
return add(_that.expense);case RequestAddExpense():
return requestAddExpense();case OpenDetailEvent():
return openDetail(_that.expenseId);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( Expense expense)?  add,TResult? Function()?  requestAddExpense,TResult? Function( String expenseId)?  openDetail,}) {final _that = this;
switch (_that) {
case LoadExpenses() when load != null:
return load();case AddExpense() when add != null:
return add(_that.expense);case RequestAddExpense() when requestAddExpense != null:
return requestAddExpense();case OpenDetailEvent() when openDetail != null:
return openDetail(_that.expenseId);case _:
  return null;

}
}

}

/// @nodoc


class LoadExpenses implements ExpenseListEvent {
  const LoadExpenses();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadExpenses);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListEvent.load()';
}


}




/// @nodoc


class AddExpense implements ExpenseListEvent {
  const AddExpense(this.expense);
  

 final  Expense expense;

/// Create a copy of ExpenseListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddExpenseCopyWith<AddExpense> get copyWith => _$AddExpenseCopyWithImpl<AddExpense>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpense&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,expense);

@override
String toString() {
  return 'ExpenseListEvent.add(expense: $expense)';
}


}

/// @nodoc
abstract mixin class $AddExpenseCopyWith<$Res> implements $ExpenseListEventCopyWith<$Res> {
  factory $AddExpenseCopyWith(AddExpense value, $Res Function(AddExpense) _then) = _$AddExpenseCopyWithImpl;
@useResult
$Res call({
 Expense expense
});


$ExpenseCopyWith<$Res> get expense;

}
/// @nodoc
class _$AddExpenseCopyWithImpl<$Res>
    implements $AddExpenseCopyWith<$Res> {
  _$AddExpenseCopyWithImpl(this._self, this._then);

  final AddExpense _self;
  final $Res Function(AddExpense) _then;

/// Create a copy of ExpenseListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expense = null,}) {
  return _then(AddExpense(
null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as Expense,
  ));
}

/// Create a copy of ExpenseListEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseCopyWith<$Res> get expense {
  
  return $ExpenseCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}

/// @nodoc


class RequestAddExpense implements ExpenseListEvent {
  const RequestAddExpense();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestAddExpense);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListEvent.requestAddExpense()';
}


}




/// @nodoc


class OpenDetailEvent implements ExpenseListEvent {
  const OpenDetailEvent(this.expenseId);
  

 final  String expenseId;

/// Create a copy of ExpenseListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenDetailEventCopyWith<OpenDetailEvent> get copyWith => _$OpenDetailEventCopyWithImpl<OpenDetailEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenDetailEvent&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId));
}


@override
int get hashCode => Object.hash(runtimeType,expenseId);

@override
String toString() {
  return 'ExpenseListEvent.openDetail(expenseId: $expenseId)';
}


}

/// @nodoc
abstract mixin class $OpenDetailEventCopyWith<$Res> implements $ExpenseListEventCopyWith<$Res> {
  factory $OpenDetailEventCopyWith(OpenDetailEvent value, $Res Function(OpenDetailEvent) _then) = _$OpenDetailEventCopyWithImpl;
@useResult
$Res call({
 String expenseId
});




}
/// @nodoc
class _$OpenDetailEventCopyWithImpl<$Res>
    implements $OpenDetailEventCopyWith<$Res> {
  _$OpenDetailEventCopyWithImpl(this._self, this._then);

  final OpenDetailEvent _self;
  final $Res Function(OpenDetailEvent) _then;

/// Create a copy of ExpenseListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenseId = null,}) {
  return _then(OpenDetailEvent(
null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ExpenseListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListState()';
}


}

/// @nodoc
class $ExpenseListStateCopyWith<$Res>  {
$ExpenseListStateCopyWith(ExpenseListState _, $Res Function(ExpenseListState) __);
}


/// Adds pattern-matching-related methods to [ExpenseListState].
extension ExpenseListStatePatterns on ExpenseListState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Expense> expenses)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.expenses);case _Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Expense> expenses)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.expenses);case _Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Expense> expenses)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.expenses);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ExpenseListState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListState.initial()';
}


}




/// @nodoc


class _Loading implements ExpenseListState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseListState.loading()';
}


}




/// @nodoc


class _Loaded implements ExpenseListState {
  const _Loaded(final  List<Expense> expenses): _expenses = expenses;
  

 final  List<Expense> _expenses;
 List<Expense> get expenses {
  if (_expenses is EqualUnmodifiableListView) return _expenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expenses);
}


/// Create a copy of ExpenseListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._expenses, _expenses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_expenses));

@override
String toString() {
  return 'ExpenseListState.loaded(expenses: $expenses)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ExpenseListStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Expense> expenses
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ExpenseListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenses = null,}) {
  return _then(_Loaded(
null == expenses ? _self._expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<Expense>,
  ));
}


}

/// @nodoc


class _Error implements ExpenseListState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of ExpenseListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ExpenseListState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ExpenseListStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ExpenseListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
