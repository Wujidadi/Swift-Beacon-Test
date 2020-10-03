import UIKit
import CoreLocation

class ViewController: UIViewController
{
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var msgLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        monitorBeacons()
    }

    func monitorBeacons()
    {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)
        {
            let uuid = UUID(uuidString: "0A4D8B73-7F74-4A83-B2CA-4FE84E870426")
            let beaconId = "TUT"
            let region = CLBeaconRegion(proximityUUID: uuid!, identifier: beaconId)
            locationManager.startMonitoring(for: region)
            locationManager.startRangingBeacons(in: region)
        }
    }
    
    // func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
    // {
    //     print("enter region")

    //     if CLLocationManager.isRangingAvailable()
    //     {
    //         locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
    //     }

    //     let content = UNMutableNotificationContent()
    //     content.title = "注意"
    //     content.subtitle = "小明就在你身邊"
    //     content.badge = 1
    //     content.sound = UNNotificationSound.default

    //     let request = UNNotificationRequest(identifier: "notification", content: content, trigger: nil)
    //     UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    //     if CLLocationManager.isRangingAvailable()
    //     {
    //         locationManager.startMonitoring(for: region as! CLBeaconRegion)
    //         locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
    //     }
    // }

    // func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
    // {
    //     print("exit region")

    //     locationManager.stopRangingBeacons(in: region as! CLBeaconRegion)
    // }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion)
    {
        let currentDate = Date()
        let dataFormatter = DateFormatter()
        dataFormatter.locale = Locale(identifier: "zh_Hant_TW")
        dataFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateString = dataFormatter.string(from: currentDate)

        // print(beacons)

        if beacons.count > 0
        {
            let beacon = beacons[0]
            var beaconString = "[\(dateString)] UUID: \(beacon.proximityUUID), Major: \(beacon.major), Minor: \(beacon.minor)"
            
            // switch beacon.proximity
            // {
            //     case .immediate:
            //         beaconString += ", Proximity: immediate"

            //     case .near:
            //         beaconString += ", Proximity: near"

            //     case .far:
            //         beaconString += ", Proximity: far"

            //     case .unknown:
            //         beaconString += ", Proximity: unknown"

            //     @unknown default:
            //         beaconString += ", Proximity: @unknown default"
            // }

            beaconString += ", RSSI: \(beacon.rssi)"

            msgLabel.text = beaconString
            print(beaconString)
        }
    }
}

extension ViewController: CLLocationManagerDelegate
{

}
