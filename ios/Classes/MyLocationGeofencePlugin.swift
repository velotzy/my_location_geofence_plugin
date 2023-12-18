import Flutter
import CoreLocation

public class MyLocationGeofencePlugin: NSObject, FlutterPlugin, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
    private var polygonRegions: [CLCircularRegion] = []
    private var eventSink: FlutterEventSink?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "my_location_plugin", binaryMessenger: registrar.messenger())
        let instance = MyLocationGeofencePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        // Set up the event channel
        let eventChannel = FlutterEventChannel(name: "location_events", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(MyEventStreamHandler(eventSink: instance.eventSink))
    }

    private func handleEventSink(sink: FlutterEventSink?) {
    self.eventSink = sink
}


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("start listener")
        print(call.method)
        switch call.method {
        case "startMonitoringPolygons":
            if let arguments = call.arguments as? [String: Any],
               let polygons = arguments["polygons"] as? [[String: Any]] {
                print("start monitor polygons handler")
                
                startMonitoringPolygons(polygons: polygons)
            }
            result(nil)
        case "stopMonitoringPolygons":
            stopMonitoringPolygons()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func startMonitoringPolygons(polygons: [[String: Any]]) {
        print("start monitor polygons")
        stopMonitoringPolygons()

        for polygon in polygons {
            if let vertices = polygon["vertices"] as? [[String: Double]],
               let identifier = polygon["identifier"] as? String,
               let radius = polygon["radius"] as? Double {
                let circularRegion = createCircularRegion(vertices: vertices, radius: radius, identifier: identifier)
                polygonRegions.append(circularRegion)
                locationManager?.startMonitoring(for: circularRegion)
            }
        }
    }

    private func stopMonitoringPolygons() {
        for region in polygonRegions {
            locationManager?.stopMonitoring(for: region)
        }
        polygonRegions.removeAll()
    }

    private func createCircularRegion(vertices: [[String: Double]], radius: Double, identifier: String) -> CLCircularRegion {
        let circularRegion = CLCircularRegion(center: center, radius: radius, identifier: identifier)
        circularRegion.notifyOnEntry = true
        circularRegion.notifyOnExit = true
        return circularRegion
    }
    
    // MARK: - CLLocationManagerDelegate

    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        notifyFlutterEvent("Entered region: \(region.identifier)")
    }

    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        notifyFlutterEvent("Exited region: \(region.identifier)")
    }

    func notifyFlutterEvent(_ message: String) {
    // Replace "your_event_channel_name" with your actual event channel name
    let eventChannel = FlutterEventChannel(name: "location_events", binaryMessenger: self)
    eventChannel.setStreamHandler(self)
    eventChannel.sendEvent(message)
}
}

class MyEventStreamHandler: NSObject, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?

    init(eventSink: FlutterEventSink?) {
        self.eventSink = eventSink
    }

    func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    func sendEvent(_ event: String) {
        eventSink?(event)
    }
}

