#import "raindeer.h"
#import "troupeau.h"
#import <Foundation/Foundation.h>
 
int main() 
{
    // obligatoire dans un main
    NSAutoreleasePool *myPool = [[NSAutoreleasePool alloc] init];
    NSString *path = @"input";
    NSError *err;
    NSString *contentFile = [[NSString alloc] initWithContentsOfFile:path
                                        encoding:NSUTF8StringEncoding 
                                        error:&err];
    NSArray *lines = [contentFile componentsSeparatedByString:@"\n"];
    NSMutableArray *listDeer = [[NSMutableArray alloc] init];
    Troupeau *troupeau = [[Troupeau alloc] init];

    for (NSString *tmp in lines)
    {
        NSArray *parsedSpace = [tmp componentsSeparatedByString:@" "];
        if ([parsedSpace count] > 2)
        {
            Raindeer *rd = [Raindeer initWithName:[parsedSpace objectAtIndex:0]
                                     zatSpeed:[[parsedSpace objectAtIndex:3]  integerValue]
                                     boostTime:[[parsedSpace objectAtIndex:6] integerValue]
                                     LunchTime:[[parsedSpace objectAtIndex:13] integerValue]];
            [troupeau newDeer:rd];
        }        
    }

    /*
    int ret = 0;
    int tmp = 0;
    for (Raindeer *rd in listDeer)
    {
        tmp = [rd calculDistance:2503];
        if (tmp > ret)
            ret = tmp;
        [rd release];
    }
    */
    int time = 2503;
    NSLog(@"le résultat est : %d", [troupeau courseUne:time]);
    NSLog(@"le résultat est : %d", [troupeau courseDeux:time]);

    //finir le main par ça
    [contentFile release];
    [listDeer release];
    [myPool drain];
    return 0;
}
