//
//  BRTableViewController.swift
//  BlogReader
//
//  Created by Ashish Sharma on 2/6/17.
//  Copyright © 2017 Ashish All rights reserved.
//

import UIKit

class BRTableViewController: UITableViewController, XMLParserDelegate  {

    var parser: XMLParser = XMLParser()
    var blogPosts: [BlogPost] = []
    var postTitle: String = String()
    var postLink: String = String()
    var eName: String = String()
    var aName: String = String()
    var postName: String = String()
    var postImage: String = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url:URL = URL(string: "https://news.google.com/news?cf=all&hl=en&pz=1&ned=in&output=rss")!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
    }
    
    // MARK: - NSXMLParserDelegate methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        
        eName = elementName
        if elementName == "item"
        {
            postTitle = String()
            postLink = String()
            postImage = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        
        let data = string
        if (!data.isEmpty)
        {
            if eName == "title"
            {
                postTitle += data
            }
            else if eName == "link"
            {
                postLink += data
            }
            else if eName == "description"
            {
                //print (string)
                if (string.contains("/images?q"))
                {
                    let realsource = data
                    let cutSource = "http:"+realsource
                    postImage += cutSource
                }
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item"
        {
            let blogPost: BlogPost = BlogPost()
            blogPost.postTitle = postTitle
            blogPost.postLink = postLink
            blogPost.postImage = postImage
            blogPosts.append(blogPost)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        let blogPost: BlogPost = blogPosts[indexPath.row]
        cell.textLabel?.text = blogPost.postTitle
        let url = NSURL(string: blogPost.postImage)
        let newData = NSData(contentsOf: url! as URL)
        cell.imageView?.image = UIImage(data: newData as! Data)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
         return 60.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!)  {
        if segue.identifier == "viewpost"
        {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let blogPost: BlogPost = blogPosts[selectedRow!]
            let viewController = segue.destination as! PostViewController
            viewController.postLink = blogPost.postLink
        }
    }
}
