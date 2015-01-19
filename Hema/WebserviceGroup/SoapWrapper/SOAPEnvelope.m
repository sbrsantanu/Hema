//
//  SOAPEnvelope.m
//  BlueList
//
//  Created by rohit.jindal on 3/27/14.
//  Copyright (c) 2014 rohit.jindal. All rights reserved.
//

#import "SOAPEnvelope.h"

@implementation SOAPEnvelope

+(NSString *) soapEnvelop
{
    return @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://csstrackingreg.webapps.cheetah.com\">";
}


+(NSString *) soapNodesForDictionary:(NSDictionary *)dict
{
    NSString *parameter = @"";
    
    if(dict != nil)
    {
        for (NSString *key in [dict allKeys]) {
            id value = [dict objectForKey:key];
            if ([value isKindOfClass:[NSDictionary class]]) {
                parameter = [NSString stringWithFormat:@"%@\n<%@>%@\n</%@>"
                             ,parameter,key,[self soapNodesForDictionary:(NSDictionary *)value],key];
            }
            else {
                parameter = [parameter stringByAppendingString:[NSString stringWithFormat:@"\n<%@>%@</%@>",key,[dict objectForKey:key],key]];
            }
        }
    }

    return parameter;
}



+(NSString *)soapEnvelopeWithMethod:(NSString *)method andParameter:(NSDictionary *)dic
{
    NSString *parameter = @"";
    parameter = [self soapNodesForDictionary:dic];
    
    
    NSString *strMethod = [NSString stringWithFormat:@"\n<%@>%@\n</%@>",method,parameter,method];

    NSString *soapMessage = [NSString stringWithFormat:
                             @"%@"
                             "<soap:Body>%@"
                             "</soap:Body>"
                             "</soap:Envelope>",[self soapEnvelop],strMethod];
    return soapMessage;
}
@end
