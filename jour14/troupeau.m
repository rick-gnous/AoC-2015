#import "troupeau.h"
#import "raindeer.h"

@implementation Troupeau

- (id) init
{
    self = [super init];
    if (self)
    {
       recetteTri = [[NSSortDescriptor alloc] initWithKey:@"distance"
                                                    ascending:YES];
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
    int ret = 0;
    while (time > 0)
    {
        for (Raindeer *rd in troupeau)
        {
            int t = [rd updateDistance];
        }
        NSArray *tmp = [NSArray arrayWithObject:recetteTri];
        NSArray *sortedRank = [troupeau sortedArrayUsingDescriptors:tmp];
        [[sortedRank firstObject] updatePoints];
        NSLog(@"%d", [[sortedRank firstObject] points]);
        NSLog(@"Rennes : %@ pour une distance de %d", [[troupeau firstObject] name], [[troupeau firstObject] distance]);
        // copier dans le troupeau le tableau trié
        time--;
    }
    NSSortDescriptor *tt = [[NSSortDescriptor alloc] initWithKey:@"points"
                                                    ascending:YES];
    NSArray *tmpp = [NSArray arrayWithObject:tt];
    NSArray *sortedPonits = [troupeau sortedArrayUsingDescriptors:tmpp];
    NSLog(@"%d", [[sortedPonits firstObject] points]);
    ret = [[sortedPonits firstObject] points];
    
    return ret;
}

- (void) dealloc
{
    for (Raindeer *rd in troupeau)
        [rd dealloc];
    [troupeau release];
    [recetteTri release];
    [super dealloc];
}

@end
