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
    int ret = 0;
    while (time > 0)
    {
        for (Raindeer *rd in troupeau)
        {
            int t = [rd updateDistance];
        }
        [troupeau sortUsingDescriptors:recetteTriDistance];
        [[troupeau firstObject] updatePoints];
        time--;
    }
    NSSortDescriptor *tt = [[NSSortDescriptor alloc] initWithKey:@"points"
                                                     ascending:NO];
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
    //[recetteTri release];
    [super dealloc];
}

@end
