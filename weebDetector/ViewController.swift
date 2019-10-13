//
//  ViewController.swift
//  weebDetector
//
//  Created by Yaroster on 10/7/19.
//  Copyright © 2019 Yaroster. All rights reserved.
//

import Cocoa
import SwiftyXMLParser


class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func Anime_XML_link(_ sender: Any) {NSWorkspace.shared.open(NSURL(string: "https://malscraper.azurewebsites.net/")! as URL)}
    @IBAction func Manga_XML_link(_ sender: Any) {NSWorkspace.shared.open(NSURL(string: "https://malscraper.azurewebsites.net/")! as URL)}
    @IBOutlet var anime_filename_field: NSTextField!
    @IBOutlet var anime_weeb_name_congratulations: NSTextField!
    @IBOutlet var anime_weeb_percentageLabel: NSTextField!
    @IBOutlet var manga_filename_field: NSTextField!
    @IBOutlet var manga_weeb_name_congratulations: NSTextField!
    @IBOutlet var manga_weeb_percentageLabel: NSTextField!
    @IBOutlet var anime_browse_button: NSButton!
    @IBOutlet var manga_browse_button: NSButton!

    @IBAction func anime_XML_file(_ sender: Any) {
        let dialog = NSOpenPanel();
            dialog.title                   = "Choose a .xml file";
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = true;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
            dialog.allowedFileTypes        = ["xml"];
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            if (result != nil) {
                let path = result!.path
                anime_filename_field.stringValue = path
                    do {
                        let contents = try String(contentsOfFile: path)
                        let xml = try! XML.parse(contents)
                        let name = (xml.myanimelist.myinfo.user_name.text!)
                        let anime_total = Int(xml.myanimelist.myinfo.user_total_anime.text!) ?? 1
                        let anime_watching = Int(xml.myanimelist.myinfo.user_total_watching.text!) ?? 1
                        let anime_completed = Int(xml.myanimelist.myinfo.user_total_completed.text!) ?? 1
                        let anime_planned = Int(xml.myanimelist.myinfo.user_total_plantowatch.text!) ?? 1
                        let weebpercentage = (anime_completed*100)/anime_total + (anime_planned*anime_watching/anime_total)
                        print(weebpercentage)
                        anime_weeb_name_congratulations.stringValue = "Congratulations " + name + " !"
                        anime_weeb_percentageLabel.stringValue = "You're a weeb of level: " + String(weebpercentage) + "%"
                        anime_browse_button.isEnabled = false
                    } catch {
                        print("This could not be loaded")
                    }
                } else {
                    print("This isn't a valid XML file")}}else{return}}

    @IBAction func manga_XML_file(_ sender: Any) {
        let dialog = NSOpenPanel();
            dialog.title                   = "Choose a .xml file";
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = true;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
            dialog.allowedFileTypes        = ["xml"];
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            if (result != nil) {
                let path = result!.path
                manga_filename_field.stringValue = path
                    do {
                        let contents = try String(contentsOfFile: path)
                        let xml = try! XML.parse(contents)
                        let name = (xml.myanimelist.myinfo.user_name.text!)
                        let manga_total = Int(xml.myanimelist.myinfo.user_total_manga.text!) ?? 1
                        let manga_reading = Int(xml.myanimelist.myinfo.user_total_reading.text!) ?? 1
                        let manga_completed = Int(xml.myanimelist.myinfo.user_total_completed.text!) ?? 1
                        let manga_planned = Int(xml.myanimelist.myinfo.user_total_plantoread.text!) ?? 1
                        let manga_dropped = Int(xml.myanimelist.myinfo.user_total_dropped.text!) ?? 1
                        let weebpercentage = (manga_completed*100)/manga_total + (manga_planned*manga_reading/manga_total) - manga_dropped
                        manga_weeb_name_congratulations.stringValue = "Congratulations " + name + " !"
                        manga_weeb_percentageLabel.stringValue = "You're a weeb of level: " + String(weebpercentage) + "%"
                        manga_browse_button.isEnabled = false
                    } catch {
                        print("This could not be loaded")
                    }
                } else {
                    print("This isn't a valid XML file")}}else{return}}
    
    @IBAction func got_itbutton(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}
