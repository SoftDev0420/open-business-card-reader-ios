/*
	FCContact.m

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

#import "FCContact.h"

#import "FCAccount.h"
#import "FCAddress.h"
#import "FCEmail.h"
#import "FCIm.h"
#import "FCName.h"
#import "FCOrganization.h"
#import "FCPhoneNumber.h"
#import "FCPhoto.h"
#import "FCUrl.h"

@implementation FCContact

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:self.accounts forKey:@"accounts"];
	[encoder encodeObject:self.addresses forKey:@"addresses"];
	[encoder encodeObject:self.emails forKey:@"emails"];
	[encoder encodeObject:self.ims forKey:@"ims"];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.organizations forKey:@"organizations"];
	[encoder encodeObject:self.phoneNumbers forKey:@"phoneNumbers"];
	[encoder encodeObject:self.photos forKey:@"photos"];
	[encoder encodeObject:self.urls forKey:@"urls"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		self.accounts = [decoder decodeObjectForKey:@"accounts"];
		self.addresses = [decoder decodeObjectForKey:@"addresses"];
		self.emails = [decoder decodeObjectForKey:@"emails"];
		self.ims = [decoder decodeObjectForKey:@"ims"];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.organizations = [decoder decodeObjectForKey:@"organizations"];
		self.phoneNumbers = [decoder decodeObjectForKey:@"phoneNumbers"];
		self.photos = [decoder decodeObjectForKey:@"photos"];
		self.urls = [decoder decodeObjectForKey:@"urls"];
	}
	return self;
}

+ (NSArray *)mappingInfo
{
	return @[
			[[FCMappingInfo mappingWithKey:@"accounts"] collectionClass:[FCAccount class]],
			[[FCMappingInfo mappingWithKey:@"addresses"] collectionClass:[FCAddress class]],
			[[FCMappingInfo mappingWithKey:@"emails"] collectionClass:[FCEmail class]],
			[[FCMappingInfo mappingWithKey:@"ims"] collectionClass:[FCIm class]],
			[[FCMappingInfo mappingWithKey:@"name"] class:[FCName class]],
			[[FCMappingInfo mappingWithKey:@"organizations"] collectionClass:[FCOrganization class]],
			[[FCMappingInfo mappingWithKey:@"phoneNumbers"] collectionClass:[FCPhoneNumber class]],
			[[FCMappingInfo mappingWithKey:@"photos"] collectionClass:[FCPhoto class]],
			[[FCMappingInfo mappingWithKey:@"urls"] collectionClass:[FCUrl class]]
	];
}

@end
