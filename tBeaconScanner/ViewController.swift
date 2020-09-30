import UIKit
import CoreLocation

class ViewController: UIViewController
{
    var locationManager: CLLocationManager!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        monitorBeacons()
    }

    func monitorBeacons()
    {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)
        {
            let proximityUUID = UUID(uuidString: "0A4D8B73-7F74-4A83-B2CA-4FE84E870426")
            let beaconId = "TUT"
            let region = CLBeaconRegion(proximityUUID: proximityUUID!, identifier: beaconId)
            locationManager.startMonitoring(for: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
    {
        print("enter region")
        
        if CLLocationManager.isRangingAvailable()
        {
            locationManager.startMonitoring(for: region as! CLBeaconRegion)
            locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
        }

        let content = UNMutableNotificationContent()
        content.title = "注意"
        content.subtitle = "小明就在你身邊"
        content.badge = 1
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        if CLLocationManager.isRangingAvailable()
        {
            locationManager.startMonitoring(for: region as! CLBeaconRegion)
            locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
        }
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
    {
        print("exit region")

        locationManager.stopRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion)
    {
        if beacons.count > 0
        {
            let nearestBeacon = beacons[0]
            print(nearestBeacon.proximityUUID, nearestBeacon.major, nearestBeacon.minor)
            
            switch nearestBeacon.proximity
            {
                case .immediate:
                    print("immediate")

                case .near:
                    print("near")

                case .far:
                    print("far")

                case .unknown:
                    print("unknown")

                @unknown default:
                    print("@unknown default")
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate
{

}
