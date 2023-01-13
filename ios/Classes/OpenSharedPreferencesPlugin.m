#import "OpenSharedPreferencesPlugin.h"
#if __has_include(<open_shared_preferences/open_shared_preferences-Swift.h>)
#import <open_shared_preferences/open_shared_preferences-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "open_shared_preferences-Swift.h"
#endif

@implementation OpenSharedPreferencesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpenSharedPreferencesPlugin registerWithRegistrar:registrar];
}
@end
