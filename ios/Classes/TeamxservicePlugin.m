#import "TeamxservicePlugin.h"
#if __has_include(<teamxservice/teamxservice-Swift.h>)
#import <teamxservice/teamxservice-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "teamxservice-Swift.h"
#endif

@implementation TeamxservicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTeamxservicePlugin registerWithRegistrar:registrar];
}
@end
