//
//  reachabilityEx.swift
//  RestContries
//
//  Created by Adam on 7/17/20.
//  Copyright © 2020 TaskApp. All rights reserved.
//

import UIKit
import Reachability

extension SearchCountryViewController{
    func startHost(at index: Int) {
        stopNotifier()
        setupReachability(hostNames[index], useClosures: true)
        startNotifier()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.startHost(at: (index + 1) % 3)
        }
    }
   
    func setupReachability(_ hostName: String?, useClosures: Bool) {
        let reachability: Reachability?
        if let hostName = hostName {
            reachability = try? Reachability(hostname: hostName)
        } else {
            reachability = try? Reachability()
        }
        self.reachability = reachability
       

        if useClosures {
            reachability?.whenReachable = { reachability in
                print("Connncted")
            }
            reachability?.whenUnreachable = { reachability in
                print("Disconnected")
            }
        } else {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(reachabilityChanged(_:)),
                name: .reachabilityChanged,
                object: reachability
            )
        }
    }
    
    
    func startNotifier() {
        print("--- start notifier")
        do {
            try reachability?.startNotifier()
        } catch {
            
            return
        }
    }

    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.connection != .unavailable {
            print(reachability)
        } else {
            print(reachability)
        }
    }
    func stopNotifier() {
          print("--- stop notifier")
          reachability?.stopNotifier()
          NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
          reachability = nil
      }
    
  
}
