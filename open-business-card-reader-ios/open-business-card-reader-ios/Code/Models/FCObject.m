/*
	FCObject.m

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


#import "FCObject.h"

typedef NS_ENUM(NSInteger, FCMappingType) {
	FCMappingTypeSimple,
	FCMappingTypeObject,
	FCMappingTypeCollection,
};


@interface FCMappingInfo ()
@property(nonatomic) FCMappingType type;
@end


@implementation FCMappingInfo

- (instancetype)initWithKeyPath:(NSString *)keyPath
                        jsonKey:(NSString *)jsonKey
{
	if ((self = [super init])) {
		_keyPath = keyPath;
		_jsonKey = jsonKey;
	}
	return self;
}


+ (instancetype)mappingWithKeyPath:(NSString *)keyPath
                           jsonKey:(NSString *)jsonKey
{
	return [[self alloc] initWithKeyPath:keyPath jsonKey:jsonKey];
}


+ (instancetype)mappingWithKey:(NSString *)key
{
	return [[self alloc] initWithKeyPath:key jsonKey:key];
}


- (instancetype)convertNumberToString:(BOOL)convertNumberToString
{
	_convertNumberToString = convertNumberToString;
	return self;
}


- (instancetype)class:(Class)class
{
	NSParameterAssert(class != nil);
	NSParameterAssert([class isSubclassOfClass:[FCObject class]]);
	_klass = class;
	_type = FCMappingTypeObject;
	return self;
}


- (instancetype)collectionClass:(Class)class
{
	NSParameterAssert(class != nil);
	NSParameterAssert([class isSubclassOfClass:[FCObject class]]);
	_klass = class;
	_type = FCMappingTypeCollection;
	return self;
}

@end


@implementation FCObject

+ (instancetype)objectFromJSON:(NSDictionary *)json
{
	if (![json isKindOfClass:[NSDictionary class]]) return nil;

	FCObject *object = [[self alloc] init];
	for (FCMappingInfo *mapping in [self mappingInfo]) {
		id value = json[mapping.jsonKey];
		if (!value || value == [NSNull null]) continue;

		switch (mapping.type) {
			case FCMappingTypeSimple:
				if (mapping.convertNumberToString && [value isKindOfClass:[NSNumber class]]) {
					value = [(NSNumber *) value stringValue];
				}
		        break;
			case FCMappingTypeObject:
				value = [mapping.klass objectFromJSON:value];
		        break;
			case FCMappingTypeCollection:
				value = [self collectionWithClass:mapping.klass fromJSON:value];
		        break;
		}

		if (!value) continue;
		[object setValue:value forKeyPath:mapping.keyPath];
	};
	return object;
}


+ (NSArray *)collectionWithClass:(Class)class
                        fromJSON:(NSArray *)json
{
	if (![json isKindOfClass:[NSArray class]]) return nil;
	NSMutableArray *collection = [NSMutableArray arrayWithCapacity:json.count];
	for (NSDictionary *objectJson in json) {
		FCObject *object = [class objectFromJSON:objectJson];
		if (object) {
			[collection addObject:object];
		}
	}
	return collection;
}


- (NSDictionary *)JSONRepresentation
{
	NSArray *mappings = [[self class] mappingInfo];
	NSMutableDictionary *json = [NSMutableDictionary dictionaryWithCapacity:mappings.count];
	for (FCMappingInfo *mapping in mappings) {
		id value = [self valueForKeyPath:mapping.keyPath];

		switch (mapping.type) {
			case FCMappingTypeObject:
				if (![value isKindOfClass:[FCObject class]]) continue;
		        value = [(FCObject *) value JSONRepresentation];
		        break;
			case FCMappingTypeCollection:
				value = [[self class] JSONFromCollection:value];
		        break;
			case FCMappingTypeSimple:
				break;
		}

		if (!value) continue;

		json[mapping.jsonKey] = value;
	}
	return json;
}


+ (NSArray *)JSONFromCollection:(NSArray *)collection
{
	if (![collection isKindOfClass:[NSArray class]]) return nil;
	NSMutableArray *json = [NSMutableArray arrayWithCapacity:collection.count];
	for (FCObject *object in collection) {
		if (![object isKindOfClass:[FCObject class]]) continue;
		[json addObject:[object JSONRepresentation]];
	}
	return json;
}


+ (NSArray *)mappingInfo
{
	NSString *reason = [NSString stringWithFormat:@"Expected subclass %@ to define method %@", NSStringFromClass(self), NSStringFromSelector(_cmd)];
	@throw [NSException exceptionWithName:@"Abstract method not implemented" reason:reason userInfo:nil];
}

@end
