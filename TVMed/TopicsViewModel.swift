//
//  TopicsViewModel.swift
//  TVMed
//
//  Created by Vinicius Albino on 10/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Foundation
import Cocoa
import Alamofire
import MediaPlayer

protocol TopicsDelegate: class {
    func contentDidFinishedLoading(success: Bool)
    func playVideo(url: String, subTopicID: String)
    func downloadVideo(url: String)
    func errorOnPlayingVideo()
}

class TopicsViewModel {
    
    private var delegate: TopicsDelegate?
    private var topicsRemoteService = NewReleasesRequest()
    private var videoRemoteService = VideoRequest()
    private var topics: MidiaDetail?
    
    init(delegate: TopicsDelegate?) {
        self.delegate = delegate
    }
    
    func loadTopics(midia: MidiaPromotion) {
        topicsRemoteService.getTopic(midia: midia) { midiaDetail, error in
            guard error == nil, let midia = midiaDetail else {
                self.delegate?.contentDidFinishedLoading(success: false)
                return
            }
            self.topics = midia
            self.delegate?.contentDidFinishedLoading(success: true)
        }
    }
    
    func getTitle() -> String {
        if let topic = topics {
            return topic.congressoTitulo
        } else {
            return ""
        }
    }
    
    func isMovietDownloaded(subTopic: MidiaSubTopic) -> Bool {
        if let path = subTopic.urlInDocumentsDirectory?.path {
            let fileManager = FileManager.default
            return fileManager.fileExists(atPath: path)
        }
        return false
    }
    
    func downloadMovie(topicID: String, url: URL ,completionHandler: (Double?, NSError?) -> Void) {
        Alamofire.download(url, method: .get, to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            let pathComponent = topicID
            
            let fileManager = FileManager.default
            let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = directoryURL.appendingPathComponent(pathComponent) as URL
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        })
            .downloadProgress(queue: DispatchQueue.global(qos: .background), closure: { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            })
            .responseData { response in
            if let data = response.result.value {
                print(data.count)
            }
        }
    }
    
    func numberOfSections() -> Int {
        guard let topic = topics else {
            return 0
        }
        return topic.topicos.count
    }
    
    func numberOfItensInSection(section: Int) -> Int {
        guard let topic = topics else {
            return 0
        }
        return topic.topicos.object(index: section)?.subTopicos.count ?? 0
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        guard let topic = topics else {
            return ""
        }
        return topic.topicos.object(index: section)?.titulo ?? ""
    }
    
    func itemForSection(section: Int, row: Int) -> MidiaSubTopic {
        guard let topic = topics else {
            return MidiaSubTopic()
        }
        return topic.topicos.object(index: section)?.subTopicos.object(index: row) ?? MidiaSubTopic()
    }
    
    func validatesUserToken(subTopicID: String) {
        DispatchQueue.main.async {
            do {
                let realm = try RealmEncrypted.realm()
                let objects = Array(realm.objects(UDID.self))
                if let udid = objects.first {
                    self.validatesVideoToken(uid: udid, subTopicID: subTopicID)
                } else {
                    self.createNewUDID(subTopicID: subTopicID)
                }
            } catch {
                self.delegate?.errorOnPlayingVideo()
                print("Realm did not query objects!")
            }
        }
    }
    
    func createNewUDID(subTopicID: String) {
        videoRemoteService.getDeviceToken { uid, error in
            guard error == nil, let udid = uid else {
                self.delegate?.errorOnPlayingVideo()
                return
            }
            let dto = UIDDTO(uid: udid.uid, nome: udid.uid, tipoDispositivo: 1)
            self.videoRemoteService.createDeviceToken(dto: dto, callback: { uid, error in
                guard error == nil, let udid = uid else {
                    self.delegate?.errorOnPlayingVideo()
                    return
                }
                self.saveNewUID(uid: udid)
                self.validatesVideoToken(uid: udid, subTopicID: subTopicID)
            })
        }
    }
    
    func saveNewUID(uid: UDID) {
        do {
            let realm = try RealmEncrypted.realm()
            try realm.write {
                realm.add(uid)
            }
        } catch {
            print("Realm did not save uid!")
        }
    }
    
    func validatesVideoToken(uid: UDID, subTopicID: String) {
        let dto = VideoTokenDTO(subTopicoId: subTopicID, uid: uid.uid)
        self.videoRemoteService.validateVideoToken(dto: dto, callback: { videoToken, error in
            guard error == nil, let token = videoToken else {
                self.delegate?.errorOnPlayingVideo()
                return
            }
            self.createsVideoURL(videoToken: token, uid: uid, subTopicID: subTopicID)
        })
    }
    
    func createsVideoURL(videoToken: VideoToken, uid: UDID, subTopicID: String) {
        let url = "http://" + videoToken.server + ":1935/vods3/_definst_/mp4:amazons3/tvmedvod/midia/" + videoToken.videoUri + "/playlist.m3u8?token=" + videoToken.token + "&uid=" + uid.uid
        self.delegate?.playVideo(url: url, subTopicID: subTopicID)
    }
}
