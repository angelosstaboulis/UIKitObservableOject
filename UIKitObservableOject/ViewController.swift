//
//  ViewController.swift
//  UIKitObservableOject
//
//  Created by Angelos Staboulis on 27/4/24.
//

import UIKit
import Combine
import SDWebImage
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var viewModel:ProductViewModel
    var products = [Product](){
        didSet{
            tableView.reloadData()
        }
    }
    var descriptionCancel = Set<AnyCancellable>()
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: "", bundle: bundle)
    }
    required init?(coder: NSCoder) {
        self.viewModel = .init()
        super.init(coder: coder)
    }
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initTableView()
    }

}

extension ViewController{
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellProduct.self, forCellReuseIdentifier: "cell")
        Task{
            self.products.append(contentsOf: try await viewModel.getAllProducts())
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.products.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellProduct
              createCell(cell: cell, indexPath: indexPath)
       
        return cell
    }
    func createCell(cell:CellProduct,indexPath:IndexPath){
        DispatchQueue.main.async{
            cell.mainImage.sd_setImage(with: URL(string:self.products[indexPath.row].image))
            cell.titleLabel.text = self.products[indexPath.row].title
            cell.descriptionLabel.text = self.products[indexPath.row].description
            cell.textRating.text = String(format:"%.2f",self.products[indexPath.row].rating.rate)
            cell.textRatingParenthesis.text = "(" + String(format:"%d",self.products[indexPath.row].rating.count) + " ratings)"
            cell.priceLabel.text = Helper.shared.createCurrencyField(currencyField: self.products[indexPath.row].price)
        }
    }
}
