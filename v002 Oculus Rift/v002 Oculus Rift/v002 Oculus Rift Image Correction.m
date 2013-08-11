//
//  v002 Oculus Rift Image Correction.m
//  v002 Oculus Rift
//
//  Created by vade on 8/11/13.
//  Copyright (c) 2013 v002. All rights reserved.
//

#import "v002 Oculus Rift Image Correction.h"

#define	kQCPlugIn_Name				@"v002 Oculus Rift Image Correction"
#define	kQCPlugIn_Description		@"v002 Oculus Rift Image Correction"


@implementation v002_Oculus_Rift_Image_Correction


@dynamic inputImage;


+ (NSDictionary *)attributes
{
    return @{QCPlugInAttributeNameKey:kQCPlugIn_Name, QCPlugInAttributeDescriptionKey:kQCPlugIn_Description};
}

+ (QCPlugInExecutionMode)executionMode
{
	return kQCPlugInExecutionModeProcessor;
}

+ (QCPlugInTimeMode)timeMode
{
	return kQCPlugInTimeModeNone;
}

@end

@implementation v002_Oculus_Rift_Image_Correction (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	return YES;
}

- (void)enableExecution:(id <QCPlugInContext>)context
{
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	return YES;
}

- (void)disableExecution:(id <QCPlugInContext>)context
{
}

- (void)stopExecution:(id <QCPlugInContext>)context
{
}

@end
