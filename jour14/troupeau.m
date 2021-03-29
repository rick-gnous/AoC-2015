#import "troupeau.h"
#import "raindeer.h"

@implementation Troupeau

- (id) init
{
    self = [super init];
    if (self)
    {
        NSSortDescriptor *recetteTri = [[NSSortDescriptor alloc] initWithKey:@"distance"
                                                                ascending:NO];
        recetteTriDistance = [NSArray arrayWithObject:recetteTri];
        troupeau = [[NSMutableArray alloc] init];
    } 
    return self;
}

- (void) newDeer:(Raindeer*)rd
{
    [troupeau addObject:rd];
}

- (int) courseUne:(int)time
{
    int ret = 0, tmp = 0;
    for (Raindeer *rd in troupeau)
    {
        tmp = [rd calculDistance:time];
            if (tmp > ret)
                ret = tmp;
    }
    return ret;
}

- (int) courseDeux:(int)time
{
    while (time >= 0)
    {
        for (Raindeer *rd in troupeau)
            [rd updateDistance];
        [troupeau sortUsingDescriptors:recetteTriDistance];
        [[troupeau firstObject] updatePoints];
        time--;
    }
    NSSortDescriptor *descPoints = [[NSSortDescriptor alloc] initWithKey:@"points"
                                                             ascending:NO];
    NSArray *tmp = [NSArray arrayWithObject:descPoints];
    NSArray *sortedPoints = [troupeau sortedArrayUsingDescriptors:tmp];
    return [[sortedPoints firstObject] points];
}

- (void) dealloc
{
    [troupeau release];
    [super dealloc];
}

@end
