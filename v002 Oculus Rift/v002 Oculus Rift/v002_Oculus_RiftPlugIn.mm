//
//  v002_Oculus_RiftPlugIn.m
//  v002 Oculus Rift
//
//  Created by vade on 5/13/15.
//  Copyright (c) 2015 v002. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "v002_Oculus_RiftPlugIn.h"


#define	kQCPlugIn_Name				@"v002 Oculus Rift"
#define	kQCPlugIn_Description		@"v002 Oculus Rift - SDK 0.5.2 - Many thanks to James George for ofxOculusDK2 which this is loosely based upon."


@implementation v002_Oculus_RiftPlugIn
@synthesize didOutputStaticInformation;

@synthesize displayDeviceName;
@synthesize productName;
@synthesize manufacturer;
@synthesize version;

@synthesize resolutionWidth;
@synthesize resolutionHeight;
@synthesize screenSizeWidth;
@synthesize screenSizeHeight;
@synthesize screenSizeCenter;
@synthesize eyeToScreenDistance;
@synthesize lensSeparationDistance;
@synthesize interpupilaryDistance;

@synthesize distortionK0;
@synthesize distortionK1;
@synthesize distortionK2;
@synthesize distortionK3;

@synthesize chromaticAbberation0;
@synthesize chromaticAbberation1;
@synthesize chromaticAbberation2;
@synthesize chromaticAbberation3;

@synthesize InfoLoaded;

#pragma mark - Ports

@dynamic inputResetOrientation;
@dynamic inputEnableGravity;
@dynamic inputEnableYawCorrection;
@dynamic inputEnablePredictiveOrientation;
@dynamic inputUseQuaternion;

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
@dynamic outputDistortionK3;
@dynamic outputChromaticAbberation0;
@dynamic outputChromaticAbberation1;
@dynamic outputChromaticAbberation2;
@dynamic outputChromaticAbberation3;


+ (NSDictionary *)attributes
{
    return @{QCPlugInAttributeNameKey:kQCPlugIn_Name, QCPlugInAttributeDescriptionKey:kQCPlugIn_Description};
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
    
    if([key isEqualToString:@"inputResetOrientation"])
        return @{QCPortAttributeNameKey: @"Reset Orientation"};
    
    if([key isEqualToString:@"inputEnableGravity"])
        return @{QCPortAttributeNameKey: @"Enable Gravity",
                 QCPortAttributeDefaultValueKey : @(TRUE)};
    
    if([key isEqualToString:@"inputEnablePredictiveOrientation"])
        return @{QCPortAttributeNameKey: @"Enable Predictive Orientation",
                 QCPortAttributeDefaultValueKey : @(TRUE)};
    
    if([key isEqualToString:@"inputEnableYawCorrection"])
        return @{QCPortAttributeNameKey: @"Enable Yaw Correction",
                 QCPortAttributeDefaultValueKey : @(TRUE)};
    
    
    if([key isEqualToString:@"inputUseQuaternion"])
        return @{QCPortAttributeNameKey: @"Use Quaternion Angles",
                 QCPortAttributeDefaultValueKey : @(TRUE)};
    
    if([key isEqualToString:@"outputDisplayDeviceName"])
        return @{QCPortAttributeNameKey: @"Display Device Name"};
    
    if([key isEqualToString:@"outputProductName"])
        return @{QCPortAttributeNameKey: @"Product Name"};
    
    if([key isEqualToString:@"outputManufacturer"])
        return @{QCPortAttributeNameKey: @"Manufacturer"};
    
    if([key isEqualToString:@"outputVersion"])
        return @{QCPortAttributeNameKey: @"Version"};
    
    if([key isEqualToString:@"outputSensorAccelerationX"])
        return @{QCPortAttributeNameKey: @"Acceleration X"};
    
    if([key isEqualToString:@"outputSensorAccelerationY"])
        return @{QCPortAttributeNameKey: @"Acceleration Y"};
    
    if([key isEqualToString:@"outputSensorAccelerationZ"])
        return @{QCPortAttributeNameKey: @"Acceleration Z"};
    
    if([key isEqualToString:@"outputSensorOrientationX"])
        return @{QCPortAttributeNameKey: @"Orientation X"};
    
    if([key isEqualToString:@"outputSensorOrientationY"])
        return @{QCPortAttributeNameKey: @"Orientation Y"};
    
    if([key isEqualToString:@"outputSensorOrientationZ"])
        return @{QCPortAttributeNameKey: @"Orientation Z"};
    
    if([key isEqualToString:@"outputSensorOrientationW"])
        return @{QCPortAttributeNameKey: @"Orientation W"};
    
    if([key isEqualToString:@"outputScreenResolutionWidth"])
        return @{QCPortAttributeNameKey: @"Screen Resolution Wide"};
    
    if([key isEqualToString:@"outputScreenResolutionHeight"])
        return @{QCPortAttributeNameKey: @"Screen Resolution Height"};
    
    if([key isEqualToString:@"outputScreenSizeWidth"])
        return @{QCPortAttributeNameKey: @"Screen Size Horizontal"};
    
    if([key isEqualToString:@"outputScreenSizeHight"])
        return @{QCPortAttributeNameKey: @"Screen Size Vertical"};
    
    if([key isEqualToString:@"outputScreenCenter"])
        return @{QCPortAttributeNameKey: @"Screen Center"};
    
    if([key isEqualToString:@"outputEyeToScreenDistance"])
        return @{QCPortAttributeNameKey: @"Eye To Screen Distance"};
    
    if([key isEqualToString:@"outputLensSeparationDistance"])
        return @{QCPortAttributeNameKey: @"Lens Separation"};
    
    if([key isEqualToString:@"outputInterpupilaryDistance"])
        return @{QCPortAttributeNameKey: @"Interpupilary Distance"};
    
    if([key isEqualToString:@"outputDistortionK0"])
        return @{QCPortAttributeNameKey: @"Distortion K 0"};
    
    if([key isEqualToString:@"outputDistortionK1"])
        return @{QCPortAttributeNameKey: @"Distortion K 1"};
    
    if([key isEqualToString:@"outputDistortionK2"])
        return @{QCPortAttributeNameKey: @"Distortion K 2"};
    
    if([key isEqualToString:@"outputDistortionK3"])
        return @{QCPortAttributeNameKey: @"Distortion K 3"};
    
    if([key isEqualToString:@"outputChromaticAbberation0"])
        return @{QCPortAttributeNameKey: @"Chromatic Abberation 0"};
    
    if([key isEqualToString:@"outputChromaticAbberation1"])
        return @{QCPortAttributeNameKey: @"Chromatic Abberation 1"};
    
    if([key isEqualToString:@"outputChromaticAbberation2"])
        return @{QCPortAttributeNameKey: @"Chromatic Abberation 2"};
    
    if([key isEqualToString:@"outputChromaticAbberation3"])
        return @{QCPortAttributeNameKey: @"Chromatic Abberation 3"};
    
    return nil;
}

+ (NSArray*) sortedPropertyPortKeys
{
    return @[
             @"inputResetOrientation",
             @"inputEnableGravity",
             @"inputEnablePredictiveOrientation",
             @"inputEnableYawCorrection",
             @"inputUseQuaternion",
             @"outputDisplayDeviceName",
             @"outputProductName",
             @"outputManufacturer",
             @"outputVersion",
             @"outputSensorAccelerationX",
             @"outputSensorAccelerationY",
             @"outputSensorAccelerationZ",
             @"outputSensorOrientationX",
             @"outputSensorOrientationY",
             @"outputSensorOrientationZ",
             @"outputSensorOrientationW",
             @"outputScreenResolutionWidth",
             @"outputScreenResolutionHeight",
             @"outputScreenSizeWidth",
             @"outputScreenSizeHight",
             @"outputScreenCenter",
             @"outputEyeToScreenDistance",
             @"outputLensSeparationDistance",
             @"outputInterpupilaryDistance",
             @"outputDistortionK0",
             @"outputDistortionK1",
             @"outputDistortionK2",
             @"outputDistortionK3",
             @"outputChromaticAbberation0",
             @"outputChromaticAbberation1",
             @"outputChromaticAbberation2",
             @"outputChromaticAbberation3"];
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
    ovrInitParams params = {0, 0, nullptr, 0};

    ovr_Initialize(&params);
}

- (id)init
{
    self = [super init];
    if (self)
    {
        hmd = ovrHmd_Create(0);

        if(!hmd)
        {
            // If we didn't detect an Hmd, create a simulated one for debugging.
            hmd = ovrHmd_CreateDebug(ovrHmd_DK1);
            if (!hmd)
            {
                // Failed Hmd creation.
                NSLog(@"Unable to create HMD");
                return nil;
            }
        }
        if(hmd)
        {
            self.InfoLoaded = YES;
            
            // Start the sensor which provides the Rift’s pose and motion.
            ovrHmd_ConfigureTracking(hmd, ovrTrackingCap_Orientation | ovrTrackingCap_MagYawCorrection |ovrTrackingCap_Position, 0);

        }
        
        if (self.InfoLoaded)
        {
            self.displayDeviceName = [NSString stringWithCString:(hmd->DisplayDeviceName) encoding:NSASCIIStringEncoding];
            self.productName = [NSString stringWithCString:hmd->ProductName encoding:NSASCIIStringEncoding];
            self.manufacturer = [NSString stringWithCString:hmd->Manufacturer encoding:NSASCIIStringEncoding];
            self.version = hmd->FirmwareMajor;
            self.resolutionWidth = hmd->Resolution.w;
            self.resolutionHeight = hmd->Resolution.h;
//            self.screenSizeWidth = Info.HScreenSize;
//            self.screenSizeHeight = Info.VScreenSize;
//            self.screenSizeCenter = Info.VScreenCenter;
//            self.eyeToScreenDistance = Info.EyeToScreenDistance;
//            self.lensSeparationDistance = Info.LensSeparationDistance;
//            self.interpupilaryDistance = Info.InterpupillaryDistance;
//            self.distortionK0 = Info.DistortionK[0];
//            self.distortionK1 = Info.DistortionK[1];
//            self.distortionK2 = Info.DistortionK[2];
//            self.distortionK3 = Info.DistortionK[3];
//            self.chromaticAbberation0 = Info.ChromaAbCorrection[0];
//            self.chromaticAbberation1 = Info.ChromaAbCorrection[1];
//            self.chromaticAbberation2 = Info.ChromaAbCorrection[2];
//            self.chromaticAbberation3 = Info.ChromaAbCorrection[3];
        }
    }
    
    return self;
}

- (void) dealloc
{
    
    if (hmd)
    {
        ovrHmd_Destroy(hmd);
        hmd = 0;
    }
    
    ovr_Shutdown();
    
    [super dealloc];
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
    
    if([self didValueForInputKeyChange:@"inputResetOrientation"])
    {
        if(self.inputResetOrientation)
            ovrHmd_RecenterPose(hmd);
    }
    
//    if([self didValueForInputKeyChange:@"inputEnableGravity"])
//    {
//        FusionResult.SetGravityEnabled((bool)self.inputEnableGravity);
//    }
//    
//    if([self didValueForInputKeyChange:@"inputEnableYawCorrection"])
//    {
//        FusionResult.SetYawCorrectionEnabled((bool)self.inputEnableYawCorrection);
//    }
//    
//    if(self.inputEnablePredictiveOrientation)
//        quaternion = FusionResult.GetPredictedOrientation();
//    else
//        quaternion = FusionResult.GetOrientation();

    
    // get our tracking data
    ovrTrackingState ts = ovrHmd_GetTrackingState(hmd, ovr_GetTimeInSeconds());
 
    if (ts.StatusFlags & (ovrStatus_OrientationTracked))
    {
        Vector3f tmpAcc=  ts.RawSensorData.Accelerometer;
        self.outputSensorAccelerationX = tmpAcc.x;
        self.outputSensorAccelerationY = tmpAcc.y;
        self.outputSensorAccelerationZ = tmpAcc.z;
    }

    if (ts.StatusFlags & (ovrStatus_OrientationTracked | ovrStatus_PositionTracked))
    {
        ovrQuatf quaternion = ts.HeadPose.ThePose.Orientation;
        if(self.inputUseQuaternion)
        {
            self.outputSensorOrientationX = quaternion.x;
            self.outputSensorOrientationY = quaternion.y;
            self.outputSensorOrientationZ = quaternion.z;
            self.outputSensorOrientationW = quaternion.w;
        }
        else
        {
            float x;
            float y;
            float z;

            Quatf quat = Quatf(quaternion.x, quaternion.y, quaternion.z, quaternion.w);
            
            //quat.GetYawPitchRoll(&x, &y, &z);
            quat.GetEulerAngles<Axis_Z, Axis_Y, Axis_X, Rotate_CCW, Handed_R>(&z, &y, &x);
            
            self.outputSensorOrientationX = RadToDegree(-x);
            self.outputSensorOrientationY = RadToDegree(-y);
            self.outputSensorOrientationZ = RadToDegree(-z);
            self.outputSensorOrientationW = 0;
        }

    }
    
    
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

