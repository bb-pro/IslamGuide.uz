//
//  SettingsViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 04/05/23.
//

import UIKit

final class SettingsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
                cell.styleView()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "shareCell", for: indexPath) as! SettingCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! SettingCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! SettingCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! SettingCell
                return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

//MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                tableView.deselectRow(at: indexPath, animated: true)
            case 1:
                shareApp()
            case 2:
                performSegue(withIdentifier: "showInfo", sender: nil)
            case 3:
                openLink(urlString: "https://www.linkedin.com/in/bektemur-mamashaev-674a42216/")
            default:
                performSegue(withIdentifier: "showLanguages", sender: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Private Methods
private extension SettingsViewController {
    func openLink(urlString: String) {
        if let url = URL(string: urlString) {
            // Open the URL
            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    // The URL was opened successfully
                    print("URL opened successfully")
                } else {
                    // Failed to open the URL
                    print("Failed to open URL")
                }
            }
        } else {
            // Invalid URL
            print("Invalid URL")
        }
    }

    
    func shareApp() {
            // Create an instance of the UIActivityViewController
            let activityViewController = UIActivityViewController(activityItems: [AppShareItem()], applicationActivities: nil)
            
            // Exclude some activity types if desired
            activityViewController.excludedActivityTypes = [.airDrop, .addToReadingList]
            
            // Present the UIActivityViewController
            present(activityViewController, animated: true, completion: nil)
        }
}

// Custom UIActivityItemSource class to provide the app's information
class AppShareItem: NSObject, UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        // Provide the content to be shared
        return "Check out this awesome app: IslamGuide"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        // Provide a subject for the sharing activity
        return "IslamGuide"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String {
        // Specify the type of data being shared (e.g., plain text, URL)
        return "public.text"
    }
}
