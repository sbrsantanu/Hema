//
//  SOAPEnvelope.h
//  BlueList
//
//  Created by rohit.jindal on 3/27/14.
//  Copyright (c) 2014 rohit.jindal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOAPEnvelope : NSObject

+(NSString *)soapEnvelopeWithMethod:(NSString *)method
                       andParameter:(NSDictionary *)dic;
@end
