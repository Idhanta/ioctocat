#import "GHEvents.h"
#import "GHEvent.h"
#import "GHRepository.h"


@implementation GHEvents

- (id)initWithRepository:(GHRepository *)repo {
	NSString *path = [NSString stringWithFormat:kRepoEventsFormat, repo.owner, repo.name];
	return [super initWithPath:path];
}

- (void)setValues:(id)values {
	self.items = [NSMutableArray array];
	for (NSDictionary *dict in values) {
		GHEvent *event = [[GHEvent alloc] initWithDict:dict];
		if ([event.date compare:self.lastUpdate] != NSOrderedDescending) {
			event.read = YES;
		}
		[self addObject:event];
	}
	self.lastUpdate = [NSDate date];
}

@end