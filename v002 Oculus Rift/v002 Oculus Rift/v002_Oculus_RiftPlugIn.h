//
//  v002_Oculus_RiftPlugIn.h
//  v002 Oculus Rift
//
//  Created by vade on 8/5/13.
//  Copyright (c) 2013 v002. All rights reserved.
//

#import <Quartz/Quartz.h>

#import "OVR.h"
using namespace OVR;

@interface v002_Oculus_RiftPlugIn : QCPlugIn
{
	Ptr<DeviceManager>	pManager;
	Ptr<HMDDevice>		pHMD;
	Ptr<SensorDevice>	pSensor;
	SensorFusion		FusionResult;
	HMDInfo				Info;
	
	BOOL didOutputStaticInformation;
	NSString* displayDeviceName;
	NSString* productName;
	NSString* manufacturer;
	NSUInteger version;
	NSUInteger resolutionWidth;
	NSUInteger resolutionHeight;
	double screenSizeWidth;
	double screenSizeHeight;
	double screenSizeCenter;
	double eyeToScreenDistance;
	double lensSeparationDistance;
	double interpupilaryDistance;
	double distortionK0;
	double distortionK1;
	double distortionK2;
	double distortionK3;
	double chromaticAbberation0;
	double chromaticAbberation1;
	double chromaticAbberation2;
	double chromaticAbberation3;
	BOOL InfoLoaded;
}

@property (atomic, readwrite, assign) BOOL didOutputStaticInformation;

@property (atomic, readwrite, copy) NSString* displayDeviceName;
@property (atomic, readwrite, copy) NSString* productName;
@property (atomic, readwrite, copy) NSString* manufacturer;
@property (atomic, readwrite, assign) NSUInteger version;

@property (atomic, readwrite, assign) NSUInteger resolutionWidth;
@property (atomic, readwrite, assign) NSUInteger resolutionHeight;
@property (atomic, readwrite, assign) double screenSizeWidth;
@property (atomic, readwrite, assign) double screenSizeHeight;
@property (atomic, readwrite, assign) double screenSizeCenter;
@property (atomic, readwrite, assign) double eyeToScreenDistance;
@property (atomic, readwrite, assign) double lensSeparationDistance;
@property (atomic, readwrite, assign) double interpupilaryDistance;

@property (atomic, readwrite, assign) double distortionK0;
@property (atomic, readwrite, assign) double distortionK1;
@property (atomic, readwrite, assign) double distortionK2;
@property (atomic, readwrite, assign) double distortionK3;

@property (atomic, readwrite, assign) double chromaticAbberation0;
@property (atomic, readwrite, assign) double chromaticAbberation1;
@property (atomic, readwrite, assign) double chromaticAbberation2;
@property (atomic, readwrite, assign) double chromaticAbberation3;

@property (atomic, readwrite, assign) BOOL InfoLoaded;


// Declare here the properties to be used as input and output ports for the plug-in e.g.
//@property double inputFoo;
//@property (copy) NSString* outputBar;


@property BOOL inputResetOrientation;
@property BOOL inputEnableGravity;
@property BOOL inputEnableYawCorrection;
@property BOOL inputEnablePredictiveOrientation;

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
