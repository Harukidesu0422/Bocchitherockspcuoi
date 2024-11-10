//
//  VCSoundTable.swift
//  Bocchitherock!
//
//  Created by Nguyen Haruki on 10/11/24.
//

import UIKit

class VCSoundTable: UIViewController {
    @IBOutlet weak var VCSoundTable: UITableView!
    var soundNames  : [String] = [
        "Gió đưa Jing Bố về trời" , "Ichiban kagayaku hoshi" , "Haru" , "There is a reason" , "5" ,
        "6" , "7" , "8" , "9" , "10"
    ]
    var selectedSound: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        }
    }
    
extension VCSoundTable: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = soundNames[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    // hiện thi khi chọn nhạc
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let content = cell?.contentConfiguration as? UIListContentConfiguration
        selectedSound = content?.text ?? "no thing"
        
    }
}
