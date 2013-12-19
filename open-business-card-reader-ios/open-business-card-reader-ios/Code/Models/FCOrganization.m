/*
	FCOrganization.m

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

#import "FCOrganization.h"

@implementation FCOrganization

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:[NSNumber numberWithBool:self.isPrimary] forKey:@"isPrimary"];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.title forKey:@"title"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		self.isPrimary = [(NSNumber *) [decoder decodeObjectForKey:@"isPrimary"] boolValue];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.title = [decoder decodeObjectForKey:@"title"];
	}
	return self;
}

+ (NSArray *)mappingInfo
{
	return @[
			[FCMappingInfo mappingWithKey:@"isPrimary"],
			[FCMappingInfo mappingWithKey:@"name"],
			[FCMappingInfo mappingWithKey:@"title"]
	];
}

@end
