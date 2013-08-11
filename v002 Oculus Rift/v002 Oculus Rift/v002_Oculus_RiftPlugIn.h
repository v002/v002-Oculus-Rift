//
//  v002_Oculus_RiftPlugIn.h
//  v002 Oculus Rift
//
//  Created by vade on 8/5/13.
//  Copyright (c) 2013 v002. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface v002_Oculus_RiftPlugIn : QCPlugIn

// Declare here the properties to be used as input and output ports for the plug-in e.g.
//@property double inputFoo;
//@property (copy) NSString* outputBar;


@property (copy) NSString* outputDisplayDeviceName;
@property (copy) NSString* outputProductName;
@property (copy) NSString* outputManufacturer;
@property NSUInteger outputVersion;

@property double outputSensorAccelerationX;
@property double outputSensorAccelerationY;
@property double outputSensorAccelerationZ;

@property double outputSensorOrientationX;
@property double outputSensorOrientationY;
@property double outputSensorOrientationZ;
@property double outputSensorOrientationW;

@property NSUInteger outputScreenResolutionWidth;
@property NSUInteger outputScreenResolutionHeight;
@property double outputScreenSizeWidth;
@property double outputScreenSizeHight;
@property double outputScreenCenter;

@property double outputEyeToScreenDistance;
@property double outputLensSeparationDistance;
@property double outputInterpupilaryDistance;

@property double outputDistortionK0;
@property double outputDistortionK1;
@property double outputDistortionK2;
@property double outputDistortionK3;

@property double outputChromaticAbberation0;
@property double outputChromaticAbberation1;
@property double outputChromaticAbberation2;
@property double outputChromaticAbberation3;


@end
