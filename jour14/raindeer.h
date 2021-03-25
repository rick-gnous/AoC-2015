#import <Foundation/Foundation.h>

@interface Raindeer : NSObject
{
    NSString *name;
    int speed;
    int boostTime;
    int pause;
}

// permet de générer des setters et getter selon des attributs
// ici retain, nonatomic et assign
@property (retain, nonatomic) NSString *name;
@property (assign) int speed, boostTime, pause;

+ (id) initWithName:(NSString*)name zatSpeed:(int)speed boostTime:(int)timeSpeed LunchTime:(int)pause;
- (int) calculDistance:(int)time;

@end
