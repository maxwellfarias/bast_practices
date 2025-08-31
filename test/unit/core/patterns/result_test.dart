import 'package:flutter_test/flutter_test.dart';
import 'package:mastering_tests/utils/result.dart';

void main() {
  group('Result Pattern Tests', () {
    group('Success', () {
      test('should create Success with data', () {
        // Arrange
        const testData = 'test data';
        
        // Act
        const result = Success(testData);
        
        // Assert
        expect(result.data, equals(testData));
        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
      });

      test('should create Success using Result.success factory', () {
        // Arrange
        const testData = 42;
        
        // Act
        final result = Result.success(testData);
        
        // Assert
        expect(result, isA<Success<int>>());
        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
      });

      test('should handle null data correctly', () {
        // Arrange & Act
        const result = Success<String?>(null);
        
        // Assert
        expect(result.data, isNull);
        expect(result.isSuccess, isTrue);
      });

      test('should be equal when data is the same', () {
        // Arrange
        const result1 = Success('test');
        const result2 = Success('test');
        
        // Act & Assert
        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('should not be equal when data is different', () {
        // Arrange
        const result1 = Success('test1');
        const result2 = Success('test2');
        
        // Act & Assert
        expect(result1, isNot(equals(result2)));
        expect(result1.hashCode, isNot(equals(result2.hashCode)));
      });

      test('should have correct toString representation', () {
        // Arrange
        const result = Success('test data');
        
        // Act
        final stringRepresentation = result.toString();
        
        // Assert
        expect(stringRepresentation, equals('Success(data: test data)'));
      });
    });

    group('Failure', () {
      test('should create Failure with error message', () {
        // Arrange
        const errorMessage = 'Something went wrong';
        
        // Act
        const result = Failure(errorMessage);
        
        // Assert
        expect(result.error, equals(errorMessage));
        expect(result.isFailure, isTrue);
        expect(result.isSuccess, isFalse);
      });

      test('should create Failure using Result.failure factory', () {
        // Arrange
        const errorMessage = 'Network error';
        
        // Act
        final result = Result<String>.failure(errorMessage);
        
        // Assert
        expect(result, isA<Failure<String>>());
        expect(result.isFailure, isTrue);
        expect(result.isSuccess, isFalse);
      });

      test('should be equal when error message is the same', () {
        // Arrange
        const result1 = Failure('error');
        const result2 = Failure('error');
        
        // Act & Assert
        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('should not be equal when error message is different', () {
        // Arrange
        const result1 = Failure('error1');
        const result2 = Failure('error2');
        
        // Act & Assert
        expect(result1, isNot(equals(result2)));
        expect(result1.hashCode, isNot(equals(result2.hashCode)));
      });

      test('should have correct toString representation', () {
        // Arrange
        const result = Failure('test error');
        
        // Act
        final stringRepresentation = result.toString();
        
        // Assert
        expect(stringRepresentation, equals('Failure(error: test error)'));
      });
    });

    group('when method', () {
      test('should call success callback for Success result', () {
        // Arrange
        const result = Success(42);
        var successCalled = false;
        var failureCalled = false;
        
        // Act
        final value = result.when(
          success: (data) {
            successCalled = true;
            return data * 2;
          },
          failure: (error) {
            failureCalled = true;
            return 0;
          },
        );
        
        // Assert
        expect(successCalled, isTrue);
        expect(failureCalled, isFalse);
        expect(value, equals(84));
      });

      test('should call failure callback for Failure result', () {
        // Arrange
        const result = Failure<int>('error');
        var successCalled = false;
        var failureCalled = false;
        
        // Act
        final value = result.when(
          success: (data) {
            successCalled = true;
            return data;
          },
          failure: (error) {
            failureCalled = true;
            return error.length;
          },
        );
        
        // Assert
        expect(successCalled, isFalse);
        expect(failureCalled, isTrue);
        expect(value, equals(5)); // "error".length
      });

      test('should return different types from callbacks', () {
        // Arrange
        const successResult = Success(100);
        const failureResult = Failure<int>('failed');
        
        // Act
        final successMessage = successResult.when(
          success: (data) => 'Value: $data',
          failure: (error) => 'Error: $error',
        );
        
        final failureMessage = failureResult.when(
          success: (data) => 'Value: $data',
          failure: (error) => 'Error: $error',
        );
        
        // Assert
        expect(successMessage, equals('Value: 100'));
        expect(failureMessage, equals('Error: failed'));
      });
    });

    group('whenOrNull method', () {
      test('should call success callback for Success result', () {
        // Arrange
        const result = Success('test');
        
        // Act
        final value = result.whenOrNull(
          success: (data) => data.toUpperCase(),
        );
        
        // Assert
        expect(value, equals('TEST'));
      });

      test('should call failure callback for Failure result', () {
        // Arrange
        const result = Failure<String>('error');
        
        // Act
        final value = result.whenOrNull(
          failure: (error) => error.toUpperCase(),
        );
        
        // Assert
        expect(value, equals('ERROR'));
      });

      test('should return null when no matching callback is provided', () {
        // Arrange
        const successResult = Success('test');
        const failureResult = Failure<String>('error');
        
        // Act
        final successValue = successResult.whenOrNull(
          failure: (error) => error.toUpperCase(),
        );
        
        final failureValue = failureResult.whenOrNull(
          success: (data) => data.toUpperCase(),
        );
        
        // Assert
        expect(successValue, isNull);
        expect(failureValue, isNull);
      });

      test('should return null when both callbacks are null', () {
        // Arrange
        const result = Success('test');
        
        // Act
        final value = result.whenOrNull();
        
        // Assert
        expect(value, isNull);
      });
    });

    group('map method', () {
      test('should transform Success data', () {
        // Arrange
        const result = Success(5);
        
        // Act
        final mappedResult = result.map((value) => value * 2);
        
        // Assert
        expect(mappedResult, isA<Success<int>>());
        expect(mappedResult.isSuccess, isTrue);
        mappedResult.when(
          success: (data) => expect(data, equals(10)),
          failure: (_) => fail('Should not be failure'),
        );
      });

      test('should preserve Failure without transformation', () {
        // Arrange
        const result = Failure<int>('original error');
        
        // Act
        final mappedResult = result.map((value) => value * 2);
        
        // Assert
        expect(mappedResult, isA<Failure<int>>());
        expect(mappedResult.isFailure, isTrue);
        mappedResult.when(
          success: (_) => fail('Should not be success'),
          failure: (error) => expect(error, equals('original error')),
        );
      });

      test('should change type when mapping', () {
        // Arrange
        const result = Success(42);
        
        // Act
        final mappedResult = result.map((value) => 'Number: $value');
        
        // Assert
        expect(mappedResult, isA<Success<String>>());
        mappedResult.when(
          success: (data) => expect(data, equals('Number: 42')),
          failure: (_) => fail('Should not be failure'),
        );
      });
    });

    group('mapError method', () {
      test('should transform Failure error message', () {
        // Arrange
        const result = Failure<String>('network error');
        
        // Act
        final mappedResult = result.mapError((error) => 'Failed: $error');
        
        // Assert
        expect(mappedResult, isA<Failure<String>>());
        expect(mappedResult.isFailure, isTrue);
        mappedResult.when(
          success: (_) => fail('Should not be success'),
          failure: (error) => expect(error, equals('Failed: network error')),
        );
      });

      test('should preserve Success without transformation', () {
        // Arrange
        const result = Success('success data');
        
        // Act
        final mappedResult = result.mapError((error) => 'Failed: $error');
        
        // Assert
        expect(mappedResult, isA<Success<String>>());
        expect(mappedResult.isSuccess, isTrue);
        mappedResult.when(
          success: (data) => expect(data, equals('success data')),
          failure: (_) => fail('Should not be failure'),
        );
      });
    });

    group('Aliases (Ok and Error)', () {
      test('Ok should be alias for Success', () {
        // Arrange & Act
        const result = Ok('test data');
        
        // Assert
        expect(result, isA<Success<String>>());
        expect(result.data, equals('test data'));
        expect(result.isSuccess, isTrue);
      });

      test('Error should be alias for Failure', () {
        // Arrange & Act
        const result = Error<String>('test error');
        
        // Assert
        expect(result, isA<Failure<String>>());
        expect(result.error, equals('test error'));
        expect(result.isFailure, isTrue);
      });

      test('Ok and Success should be interchangeable', () {
        // Arrange
        const okResult = Ok('data');
        const successResult = Success('data');
        
        // Act & Assert
        expect(okResult, equals(successResult));
        expect(okResult.runtimeType, equals(successResult.runtimeType));
      });

      test('Error and Failure should be interchangeable', () {
        // Arrange
        const errorResult = Error<String>('message');
        const failureResult = Failure<String>('message');
        
        // Act & Assert
        expect(errorResult, equals(failureResult));
        expect(errorResult.runtimeType, equals(failureResult.runtimeType));
      });
    });

    group('Type Safety', () {
      test('should maintain type safety with different data types', () {
        // Arrange
        final intResult = Result.success(42);
        final stringResult = Result.success('hello');
        final listResult = Result.success([1, 2, 3]);
        
        // Act & Assert
        expect(intResult, isA<Result<int>>());
        expect(stringResult, isA<Result<String>>());
        expect(listResult, isA<Result<List<int>>>());
      });

      test('should work with custom objects', () {
        // Arrange
        final person = _Person('John', 30);
        final result = Result.success(person);
        
        // Act & Assert
        expect(result, isA<Result<_Person>>());
        result.when(
          success: (data) {
            expect(data.name, equals('John'));
            expect(data.age, equals(30));
          },
          failure: (_) => fail('Should not be failure'),
        );
      });

      test('should handle nullable types correctly', () {
        // Arrange
        final nullableResult = Result<String?>.success(null);
        final nonNullResult = Result<String?>.success('value');
        
        // Act & Assert
        expect(nullableResult.isSuccess, isTrue);
        expect(nonNullResult.isSuccess, isTrue);
        
        nullableResult.when(
          success: (data) => expect(data, isNull),
          failure: (_) => fail('Should not be failure'),
        );
        
        nonNullResult.when(
          success: (data) => expect(data, equals('value')),
          failure: (_) => fail('Should not be failure'),
        );
      });
    });

    group('Edge Cases', () {
      test('should handle empty strings', () {
        // Arrange & Act
        const successResult = Success('');
        const failureResult = Failure<String>('');
        
        // Assert
        expect(successResult.data, equals(''));
        expect(failureResult.error, equals(''));
      });

      test('should handle very long strings', () {
        // Arrange
        final longString = 'a' * 10000;
        final result = Success(longString);
        
        // Act & Assert
        expect(result.data.length, equals(10000));
        expect(result.isSuccess, isTrue);
      });

      test('should handle complex nested data structures', () {
        // Arrange
        final complexData = <String, dynamic>{
          'users': [
            {'id': 1, 'name': 'John'},
            {'id': 2, 'name': 'Jane'},
          ],
          'meta': {'count': 2, 'page': 1},
        };
        final result = Success(complexData);
        
        // Act & Assert
        expect(result.isSuccess, isTrue);
        result.when(
          success: (data) {
            expect(data['users'], hasLength(2));
            final meta = data['meta'] as Map<String, dynamic>;
            expect(meta['count'], equals(2));
          },
          failure: (_) => fail('Should not be failure'),
        );
      });
    });

    group('Chaining Operations', () {
      test('should chain map operations on Success', () {
        // Arrange
        const result = Success(10);
        
        // Act
        final chainedResult = result
            .map((x) => x * 2)
            .map((x) => x + 5)
            .map((x) => 'Result: $x');
        
        // Assert
        chainedResult.when(
          success: (data) => expect(data, equals('Result: 25')),
          failure: (_) => fail('Should not be failure'),
        );
      });

      test('should stop chaining on first Failure', () {
        // Arrange
        const result = Failure<int>('initial error');
        
        // Act
        final chainedResult = result
            .map((x) => x * 2)
            .map((x) => x + 5)
            .mapError((error) => 'Processed: $error');
        
        // Assert
        chainedResult.when(
          success: (_) => fail('Should not be success'),
          failure: (error) => expect(error, equals('Processed: initial error')),
        );
      });
    });

    group('Result Extensions', () {
      group('valueOrNull', () {
        test('should return value for Success', () {
          // Arrange
          const result = Success('test value');
          
          // Act
          final value = result.valueOrNull;
          
          // Assert
          expect(value, equals('test value'));
        });

        test('should return null for Failure', () {
          // Arrange
          const result = Failure<String>('error');
          
          // Act
          final value = result.valueOrNull;
          
          // Assert
          expect(value, isNull);
        });

        test('should handle null values correctly', () {
          // Arrange
          const result = Success<String?>(null);
          
          // Act
          final value = result.valueOrNull;
          
          // Assert
          expect(value, isNull);
        });
      });

      group('errorOrNull', () {
        test('should return error for Failure', () {
          // Arrange
          const result = Failure<String>('test error');
          
          // Act
          final error = result.errorOrNull;
          
          // Assert
          expect(error, equals('test error'));
        });

        test('should return null for Success', () {
          // Arrange
          const result = Success('value');
          
          // Act
          final error = result.errorOrNull;
          
          // Assert
          expect(error, isNull);
        });
      });

      group('valueOr', () {
        test('should return value for Success', () {
          // Arrange
          const result = Success('actual value');
          
          // Act
          final value = result.valueOr('default value');
          
          // Assert
          expect(value, equals('actual value'));
        });

        test('should return default value for Failure', () {
          // Arrange
          const result = Failure<String>('error');
          
          // Act
          final value = result.valueOr('default value');
          
          // Assert
          expect(value, equals('default value'));
        });

        test('should work with different types', () {
          // Arrange
          const successResult = Success(42);
          const failureResult = Failure<int>('error');
          
          // Act
          final successValue = successResult.valueOr(0);
          final failureValue = failureResult.valueOr(999);
          
          // Assert
          expect(successValue, equals(42));
          expect(failureValue, equals(999));
        });
      });

      group('onSuccess', () {
        test('should execute action for Success', () {
          // Arrange
          const result = Success('test');
          var actionExecuted = false;
          String? capturedValue;
          
          // Act
          result.onSuccess((value) {
            actionExecuted = true;
            capturedValue = value;
          });
          
          // Assert
          expect(actionExecuted, isTrue);
          expect(capturedValue, equals('test'));
        });

        test('should not execute action for Failure', () {
          // Arrange
          const result = Failure<String>('error');
          var actionExecuted = false;
          
          // Act
          result.onSuccess((value) {
            actionExecuted = true;
          });
          
          // Assert
          expect(actionExecuted, isFalse);
        });
      });

      group('onError', () {
        test('should execute action for Failure', () {
          // Arrange
          const result = Failure<String>('test error');
          var actionExecuted = false;
          String? capturedError;
          
          // Act
          result.onError((error) {
            actionExecuted = true;
            capturedError = error;
          });
          
          // Assert
          expect(actionExecuted, isTrue);
          expect(capturedError, equals('test error'));
        });

        test('should not execute action for Success', () {
          // Arrange
          const result = Success('value');
          var actionExecuted = false;
          
          // Act
          result.onError((error) {
            actionExecuted = true;
          });
          
          // Assert
          expect(actionExecuted, isFalse);
        });
      });

      group('Extension Chaining', () {
        test('should chain extensions effectively', () {
          // Arrange
          const successResult = Success(100);
          const failureResult = Failure<int>('calculation failed');
          
          // Act
          var successActionCalled = false;
          var errorActionCalled = false;
          
          final successValue = successResult
              .map((x) => x * 2)
              .valueOr(0);
          
          successResult.onSuccess((_) => successActionCalled = true);
          
          final failureValue = failureResult
              .map((x) => x * 2)
              .valueOr(-1);
          
          failureResult.onError((_) => errorActionCalled = true);
          
          // Assert
          expect(successValue, equals(200));
          expect(successActionCalled, isTrue);
          expect(failureValue, equals(-1));
          expect(errorActionCalled, isTrue);
        });
      });
    });
  });
}

// Helper class for testing custom objects
class _Person {
  final String name;
  final int age;

  _Person(this.name, this.age);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is _Person && other.name == name && other.age == age);
  }

  @override
  int get hashCode => Object.hash(name, age);
}
