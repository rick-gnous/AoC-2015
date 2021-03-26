#import "raindeer.h"
#import <Foundation/Foundation.h>

@interface Troupeau : NSObject
{
    NSMutableArray *troupeau;
    NSSortDescriptor *recetteTri;
}

- (id) init;
- (void) newDeer:(Raindeer*)rd;
- (int) courseUne:(int)time;
- (int) courseDeux:(int)time;

@end
