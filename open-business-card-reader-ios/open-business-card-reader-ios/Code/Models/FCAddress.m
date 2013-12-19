/*
	FCAddress.m

	Created by Duane Schleen on 12/17/13.
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

#import "FCAddress.h"

@implementation FCAddress

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:self.country forKey:@"country"];
	[encoder encodeObject:self.locality forKey:@"locality"];
	[encoder encodeObject:self.postalCode forKey:@"postalCode"];
	[encoder encodeObject:self.region forKey:@"region"];
	[encoder encodeObject:self.streetAddress forKey:@"streetAddress"];
	[encoder encodeObject:self.type forKey:@"type"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		self.country = [decoder decodeObjectForKey:@"country"];
		self.locality = [decoder decodeObjectForKey:@"locality"];
		self.postalCode = [decoder decodeObjectForKey:@"postalCode"];
		self.region = [decoder decodeObjectForKey:@"region"];
		self.streetAddress = [decoder decodeObjectForKey:@"streetAddress"];
		self.type = [decoder decodeObjectForKey:@"type"];
	}
	return self;
}

+ (NSArray *)mappingInfo
{
	return @[
			[FCMappingInfo mappingWithKey:@"country"],
			[FCMappingInfo mappingWithKey:@"locality"],
			[FCMappingInfo mappingWithKey:@"postalCode"],
			[FCMappingInfo mappingWithKey:@"region"],
			[FCMappingInfo mappingWithKey:@"streetAddress"],
			[FCMappingInfo mappingWithKey:@"type"]
	];
}

@end
