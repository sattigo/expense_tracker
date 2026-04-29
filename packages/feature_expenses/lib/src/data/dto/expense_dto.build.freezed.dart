// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_dto.build.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExpenseDto _$ExpenseDtoFromJson(Map<String, dynamic> json) {
  return _ExpenseDto.fromJson(json);
}

/// @nodoc
mixin _$ExpenseDto {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseDtoCopyWith<ExpenseDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseDtoCopyWith<$Res> {
  factory $ExpenseDtoCopyWith(ExpenseDto value, $Res Function(ExpenseDto) then) =
      _$ExpenseDtoCopyWithImpl<$Res, ExpenseDto>;
  @useResult
  $Res call({String id, double amount, String title, String date, String category, String type});
}

/// @nodoc
class _$ExpenseDtoCopyWithImpl<$Res, $Val extends ExpenseDto> implements $ExpenseDtoCopyWith<$Res> {
  _$ExpenseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? title = null,
    Object? date = null,
    Object? category = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseDtoImplCopyWith<$Res> implements $ExpenseDtoCopyWith<$Res> {
  factory _$$ExpenseDtoImplCopyWith(_$ExpenseDtoImpl value, $Res Function(_$ExpenseDtoImpl) then) =
      __$$ExpenseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, double amount, String title, String date, String category, String type});
}

/// @nodoc
class __$$ExpenseDtoImplCopyWithImpl<$Res> extends _$ExpenseDtoCopyWithImpl<$Res, _$ExpenseDtoImpl>
    implements _$$ExpenseDtoImplCopyWith<$Res> {
  __$$ExpenseDtoImplCopyWithImpl(_$ExpenseDtoImpl _value, $Res Function(_$ExpenseDtoImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? title = null,
    Object? date = null,
    Object? category = null,
    Object? type = null,
  }) {
    return _then(
      _$ExpenseDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseDtoImpl extends _ExpenseDto {
  const _$ExpenseDtoImpl({
    required this.id,
    required this.amount,
    required this.title,
    required this.date,
    required this.category,
    required this.type,
  }) : super._();

  factory _$ExpenseDtoImpl.fromJson(Map<String, dynamic> json) => _$$ExpenseDtoImplFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  final String title;
  @override
  final String date;
  @override
  final String category;
  @override
  final String type;

  @override
  String toString() {
    return 'ExpenseDto(id: $id, amount: $amount, title: $title, date: $date, category: $category, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.category, category) || other.category == category) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, title, date, category, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseDtoImplCopyWith<_$ExpenseDtoImpl> get copyWith =>
      __$$ExpenseDtoImplCopyWithImpl<_$ExpenseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseDtoImplToJson(this);
  }
}

abstract class _ExpenseDto extends ExpenseDto {
  const factory _ExpenseDto({
    required final String id,
    required final double amount,
    required final String title,
    required final String date,
    required final String category,
    required final String type,
  }) = _$ExpenseDtoImpl;
  const _ExpenseDto._() : super._();

  factory _ExpenseDto.fromJson(Map<String, dynamic> json) = _$ExpenseDtoImpl.fromJson;

  @override
  String get id;
  @override
  double get amount;
  @override
  String get title;
  @override
  String get date;
  @override
  String get category;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseDtoImplCopyWith<_$ExpenseDtoImpl> get copyWith => throw _privateConstructorUsedError;
}
