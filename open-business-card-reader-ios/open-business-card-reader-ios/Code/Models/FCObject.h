/*
	FCObject.h

	Copyright (c) 2013 FullContact Inc.

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	you may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
 */


#import <Foundation/Foundation.h>

@interface FCObject : NSObject <NSCoding>
+ (instancetype)objectFromJSON:(NSDictionary *)json;

- (NSDictionary *)JSONRepresentation;

// Protected
+ (NSArray *)mappingInfo;
@end


@interface FCMappingInfo : NSObject
@property(nonatomic) NSString *keyPath;
@property(nonatomic) NSString *jsonKey;
@property(nonatomic) Class klass;
@property(nonatomic) BOOL convertNumberToString;

+ (instancetype)mappingWithKey:(NSString *)key;

+ (instancetype)mappingWithKeyPath:(NSString *)keyPath
                           jsonKey:(NSString *)jsonKey;

- (instancetype)convertNumberToString:(BOOL)convertNumber;

- (instancetype)class:(Class)class;

- (instancetype)collectionClass:(Class)class;
@end
