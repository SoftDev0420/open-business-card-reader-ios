/*
	FCIm.m

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

#import "FCIm.h"

@implementation FCIm

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:self.type forKey:@"type"];
	[encoder encodeObject:self.value forKey:@"value"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		self.type = [decoder decodeObjectForKey:@"type"];
		self.value = [decoder decodeObjectForKey:@"value"];
	}
	return self;
}

+ (NSArray *)mappingInfo
{
	return @[
			[FCMappingInfo mappingWithKey:@"type"],
			[FCMappingInfo mappingWithKey:@"value"]
	];
}

@end
