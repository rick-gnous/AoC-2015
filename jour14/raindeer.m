#import "raindeer.h"
#import <Foundation/Foundation.h>

@implementation Raindeer

// permet de créer les getters et setters à partir de property
@synthesize name, speed, boostTime, pause, points, cooldown, hypervitesse, distance;

+ (id) initWithName:(NSString*)name zatSpeed:(int)speed boostTime:(int)boostTime LunchTime:(int)pause
{
    Raindeer *new;
    if ((new = [[Raindeer alloc] init]))
    {
        new.name = name;
        new.speed = speed;
        new.boostTime = boostTime;
        new.pause = pause;
        new.points = 0;
        new.cooldown = 0;
        new.hypervitesse = boostTime;
        new.distance = 0;
    }
    return new;
}

- (int) calculDistance:(int) time
{
    int ret = 0;
    while (time > 0)
    {
        int rest = boostTime - time;
        ret += (rest > 0) ? speed * rest : speed * boostTime;
        time -= boostTime + pause;
    }
    return ret;
}

- (int) updateDistance
{
    if (cooldown > 0)
    {
        cooldown--;
        if (cooldown == 0)
            hypervitesse = boostTime;
    }
    else
    {
        distance = distance + speed;
        hypervitesse--;
        if (hypervitesse == 0)
            cooldown = pause;
    }
    return distance;
}

- (void) updatePoints
{
    points++;
}

- (void) dealloc
{
    [name release];
    [super dealloc];
}

@end
