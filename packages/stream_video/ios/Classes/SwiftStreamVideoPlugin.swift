import Flutter
import UIKit

public class SwiftStreamVideoPlugin: NSObject, FlutterPlugin {
  private static let voipPushTokenKey = "stream.video.voip.token"
  @objc public static var sharedInstance: SwiftStreamVideoPlugin? = nil
  private var channel: FlutterMethodChannel? = nil
  private var eventChannel: FlutterEventChannel? = nil

  public static func sharePluginWithRegister(with registrar: FlutterPluginRegistrar) -> SwiftStreamVideoPlugin {
      if(sharedInstance == nil){
          sharedInstance = SwiftStreamVideoPlugin()
      }
      sharedInstance!.channel = FlutterMethodChannel(name: "stream_video", binaryMessenger: registrar.messenger())
      sharedInstance!.eventChannel = FlutterEventChannel(name: "stream_video_events", binaryMessenger: registrar.messenger())
      return sharedInstance!
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = sharePluginWithRegister(with: registrar)
    registrar.addMethodCallDelegate(instance, channel: instance.channel!)
  }

  public static func setDevicePushTokenVoIP(deviceToken: String) {
    UserDefaults.standard.set(deviceToken, forKey: voipPushTokenKey)
    // TODO: Store this device on SwiftFlutterCallkitIncomingPlugin
    // SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP(deviceToken)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "getDevicePushTokenVoIP":
            result(UserDefaults.standard.value(forKey: voipPushTokenKey) as? String)
            break
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
