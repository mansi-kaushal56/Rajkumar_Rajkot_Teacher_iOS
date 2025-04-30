//
//  FeedbackSuggestionVC.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 18/10/23.
//

import UIKit
import ObjectMapper

class FeedbackSuggestionVC: UIViewController {
    var feedbackSuggestionObj: FeedbackSuggestionModel?
    
    @IBOutlet weak var suggestionTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Feedback/Suggestion By Parents")
        feedbackSuggestionApi()
        // Do any additional setup after loading the view.
    }
    
    @objc func repliedText(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Replied message", message:feedbackSuggestionObj?.res?[sender.view?.tag ?? 0].Reply , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
}
extension FeedbackSuggestionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackSuggestionObj?.res?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let suggestionCell = tableView.dequeueReusableCell(withIdentifier: AppStrings.AppTblVIdentifiers.suggestionCell.getIdentifier, for: indexPath) as! FeedbackSuggestionTblCell
        suggestionCell.suggestionDetailView.clipsToBounds = true
        let suggestionData = feedbackSuggestionObj?.res?[indexPath.row]
        suggestionCell.admNoLabel.text = suggestionData?.EnrollNo ?? ""
        suggestionCell.classLabel.text = suggestionData?.phone ?? ""
        suggestionCell.fromLabel.text = "\(suggestionData?.gurdianname ?? "")(\(suggestionData?.relation ?? ""))"
        suggestionCell.suggestionDescriptionLbl.text = suggestionData?.feedback ?? ""
        suggestionCell.statusLabel.text = suggestionData?.Status
        
        if suggestionData?.Status == "viewed" {
            suggestionCell.statusView.backgroundColor = UIColor.AppDarkOrange
            
        } else {
            suggestionCell.statusView.tag = indexPath.row
            suggestionCell.statusView.backgroundColor = UIColor.AppLightGreen
            let repliedTap = UITapGestureRecognizer(target: self,action: #selector(repliedText(_:)))
            suggestionCell.statusView.addGestureRecognizer(repliedTap)
        }
        return suggestionCell
    }
    
}
extension FeedbackSuggestionVC {
    func feedbackSuggestionApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(BASE_URL)\(END_POINTS.Api_Feedback_Suggestion.getEndPoints).php?SessionId=\(UserDefaults.getUserDetail()?.Session ?? "")&BranchId=\(UserDefaults.getUserDetail()?.BranchId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: END_POINTS.Api_Feedback_Suggestion.getEndPoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
extension FeedbackSuggestionVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == END_POINTS.Api_Feedback_Suggestion.getEndPoints {
            let status = response["status"] as? Bool
            if status == true {
                if let suggestionListDictData = Mapper<FeedbackSuggestionModel>().map(JSONObject: response) {
                    feedbackSuggestionObj = suggestionListDictData
                    DispatchQueue.main.async {
                        self.suggestionTblView.reloadData()
                    }
                }
            }
            CommonObjects.shared.showProgress()
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
        }
    }
    
    
}
