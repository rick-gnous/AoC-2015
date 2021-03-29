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

    const int time = 2503;
    NSLog(@"le résultat de la première sélection est : %d", [troupeau courseUne:time]);
    NSLog(@"le résultat de la deuxième sélection est : %d", [troupeau courseDeux:time]);

    //finir le main par ça
    [contentFile release];
    [listDeer release];
    [troupeau dealloc];
    [myPool drain];
    return 0;
}
