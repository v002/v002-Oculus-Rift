//
//  v002_Oculus_RiftPlugIn.m
//  v002 Oculus Rift
//
//  Created by vade on 8/5/13.
//  Copyright (c) 2013 v002. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "v002_Oculus_RiftPlugIn.h"

#import "OVR.h"
using namespace OVR;

#define	kQCPlugIn_Name				@"v002 Oculus Rift"
#define	kQCPlugIn_Description		@"v002 Oculus Rift description"

@interface v002_Oculus_RiftPlugIn ()
{
	Ptr<DeviceManager>	pManager;
	Ptr<HMDDevice>		pHMD;
	Ptr<SensorDevice>	pSensor;
	SensorFusion		FusionResult;
	HMDInfo				Info;
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

@end

@implementation v002_Oculus_RiftPlugIn

@dynamic outputDisplayDeviceName;
@dynamic outputProductName;
@dynamic outputManufacturer;
@dynamic outputVersion;

@dynamic outputSensorAccelerationX;
@dynamic outputSensorAccelerationY;
@dynamic outputSensorAccelerationZ;
@dynamic outputSensorOrientationX;
@dynamic outputSensorOrientationY;
@dynamic outputSensorOrientationZ;
@dynamic outputSensorOrientationW;
@dynamic outputScreenResolutionWidth;
@dynamic outputScreenResolutionHeight;
@dynamic outputScreenSizeWidth;
@dynamic outputScreenSizeHight;
@dynamic outputScreenCenter;
@dynamic outputEyeToScreenDistance;
@dynamic outputLensSeparationDistance;
@dynamic outputInterpupilaryDistance;
@dynamic outputDistortionK0;
@dynamic outputDistortionK1;
@dynamic outputDistortionK2;

+ (NSDictionary *)attributes
{
    return @{QCPlugInAttributeNameKey:kQCPlugIn_Name, QCPlugInAttributeDescriptionKey:kQCPlugIn_Description};
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
	return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	return kQCPlugInExecutionModeProvider;
}

+ (QCPlugInTimeMode)timeMode
{
	return kQCPlugInTimeModeIdle;
}

+ (void) initialize
{
	System::Init();
}

- (id)init
{
	self = [super init];
	if (self)
	{
		pSensor.Clear();
        pHMD.Clear();
		
		pManager = *DeviceManager::Create();
		pHMD = *pManager->EnumerateDevices<HMDDevice>().CreateDevice();
		
		if (pHMD)
		{
			self.InfoLoaded = pHMD->GetDeviceInfo(&Info);
			pSensor = *pHMD->GetSensor();
		}
		else
		{
			pSensor = *pManager->EnumerateDevices<SensorDevice>().CreateDevice();
		}
		
		if (pSensor)
		{
			FusionResult.AttachToSensor(pSensor);
		}
		
		if (pHMD)
			NSLog(@"[x] HMD Found");
		else
			NSLog(@"[ ] HMD Not Found");
		
		if (pSensor)
			NSLog(@"[x] Sensor Found" );
		else
			NSLog(@"[ ] Sensor Not Found");
				
		if (self.InfoLoaded)
		{
			self.displayDeviceName = [NSString stringWithCString:(Info.DisplayDeviceName) encoding:NSASCIIStringEncoding];
			self.productName = [NSString stringWithCString:Info.ProductName encoding:NSASCIIStringEncoding];
			self.manufacturer = [NSString stringWithCString:Info.Manufacturer encoding:NSASCIIStringEncoding];
			self.version = Info.Version;
			self.resolutionWidth = Info.HResolution;
			self.resolutionHeight = Info.VResolution;
			self.screenSizeWidth = Info.HScreenSize;
			self.screenSizeHeight = Info.VScreenSize;
			self.screenSizeCenter = Info.VScreenCenter;
			self.eyeToScreenDistance = Info.EyeToScreenDistance;
			self.lensSeparationDistance = Info.LensSeparationDistance;
			self.interpupilaryDistance = Info.InterpupillaryDistance;
			self.distortionK0 = Info.DistortionK[0];
			self.distortionK1 = Info.DistortionK[1];
			self.distortionK2 = Info.DistortionK[2];
			self.distortionK3 = Info.DistortionK[3];
			self.chromaticAbberation0 = Info.ChromaAbCorrection[0];
			self.chromaticAbberation1 = Info.ChromaAbCorrection[1];
			self.chromaticAbberation2 = Info.ChromaAbCorrection[2];
			self.chromaticAbberation3 = Info.ChromaAbCorrection[3];
		}
	}
	
	return self;
}

@end

@implementation v002_Oculus_RiftPlugIn (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	
	return YES;
}

- (void)enableExecution:(id <QCPlugInContext>)context
{
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	if(!self.didOutputStaticInformation)
	{
		
		self.outputDisplayDeviceName = self.displayDeviceName;
		self.outputProductName = self.productName;
		self.outputManufacturer = self.manufacturer;
		self.outputVersion = self.version;
		
		self.outputScreenResolutionWidth = self.resolutionWidth;
		self.outputScreenResolutionHeight = self.resolutionHeight;
		self.outputScreenSizeWidth = self.screenSizeWidth;
		self.outputScreenSizeHight = self.screenSizeHeight;
		self.outputScreenCenter = self.screenSizeCenter;
		self.outputEyeToScreenDistance = self.eyeToScreenDistance;
		self.outputLensSeparationDistance = self.lensSeparationDistance;
		self.outputInterpupilaryDistance = self.interpupilaryDistance;
		self.outputDistortionK0 = self.distortionK0;
		self.outputDistortionK1 = self.distortionK1;
		self.outputDistortionK2 = self.distortionK2;
		self.outputDistortionK3 = self.distortionK3;
		self.outputChromaticAbberation0 = self.chromaticAbberation0;
		self.outputChromaticAbberation1 = self.chromaticAbberation1;
		self.outputChromaticAbberation2 = self.chromaticAbberation2;
		self.outputChromaticAbberation3 = self.chromaticAbberation3;
		
		self.didOutputStaticInformation = YES;
	}
	
	Vector3f tmpAcc = FusionResult.GetAcceleration();
	Quatf quaternion = FusionResult.GetOrientation();

	self.outputSensorAccelerationX = tmpAcc.x;
	self.outputSensorAccelerationY = tmpAcc.y;
	self.outputSensorAccelerationZ = tmpAcc.z;
	
	self.outputSensorOrientationX = quaternion.x;
	self.outputSensorOrientationY = quaternion.y;
	self.outputSensorOrientationZ = quaternion.z;
	self.outputSensorOrientationW = quaternion.w;
	
	return YES;
}

- (void)disableExecution:(id <QCPlugInContext>)context
{
	self.didOutputStaticInformation = NO;
}

- (void)stopExecution:(id <QCPlugInContext>)context
{
}

@end
