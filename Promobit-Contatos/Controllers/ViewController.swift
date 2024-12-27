//
//  ViewController.swift
//  Promobit-Contatos
//
//  Created by Monitora on 19/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewContatos: UITableView!
    var contatos = [ContatoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        criarBotaoAdd ()
    
        if Internet.isConnected() {
            getListaContatos(orndenacao: "sortBy=name&order=asc")
        } else {
            msgInternet()
        }
        
        tableViewContatos.dataSource = self
        tableViewContatos.delegate = self
    }
    func msgInternet() {
        let alert = UIAlertController(title: "Erro", message: "Não há conexão disponível, ative sua Internet para continuar!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in }))
        self.present(alert, animated: true)
        
    }
    
    func criarBotaoAdd () {
        let buttonImage = UIImage(named: "Add")
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0);
        button.setBackgroundImage(buttonImage, for: UIControl.State())
        button.backgroundColor = UIColor(red: 27.0/255.0, green: 87.0/255.0, blue: 119.0/255.0, alpha: 1)
        button.center.x = self.tableViewContatos.frame.width - 50
        button.center.y = self.tableViewContatos.frame.height - 120
        button.layer.cornerRadius = button.frame.size.width/2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(ViewController.showMenu(_:)), for: UIControl.Event.touchUpInside)
        self.tableViewContatos.addSubview(button)
    }
    
    @objc func showMenu(_ sender: UIButton!) {
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "InsereAltera", bundle: nil)
        let viewcontroller : Inserir_AlterarViewController = mainView.instantiateViewController(withIdentifier: "InsereAltera") as! Inserir_AlterarViewController
    
        let navControl = UINavigationController(rootViewController: viewcontroller)
        navControl.modalPresentationStyle = .fullScreen
        
        viewcontroller.tipo = "Incluir"
    
        self.present(navControl, animated: true, completion: nil)

    }
    override func viewDidAppear(_ animated: Bool) {
        if Internet.isConnected(){
            getListaContatos(orndenacao: "sortBy=name&order=asc")
        } else {
            msgInternet()
        }
    }
    
    func deleteContato(id:String) {
        
        RestAPI.deleteContato(id: id, callback: {
            response in
            switch (response.result) {
            case .success( _):
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    print("201 Created")
                    
                } else  {
                    
                }
                
            case .failure(let error):
                
                print(error.localizedDescription)
                break
            }
        })
        
    }
    
    @IBAction func btnFiltro(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Filtro", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Contato - A - Z", style: .default, handler: { action in
            self.getListaContatos(orndenacao: "sortBy=name&order=asc")
        }))

        alert.addAction(UIAlertAction(title: "Contato - Z - A", style: .default, handler: { action in
            self.getListaContatos(orndenacao: "sortBy=name&order=desc")
        }))
        alert.addAction(UIAlertAction(title: "Empresa - A - Z", style: .default, handler: { action in
            self.getListaContatos(orndenacao: "sortBy=company&order=asc")
        }))

        alert.addAction(UIAlertAction(title: "Empresa - Z - A", style: .default, handler: { action in
            self.getListaContatos(orndenacao: "sortBy=company&order=desc")
        }))
        self.present(alert, animated: true)
    }

    @IBAction func btnMenuLateral(_ sender: UIBarButtonItem) {
        
        self.revealViewController().revealToggle(self)
    }
   
    func getListaContatos(orndenacao: String) {
        
        RestAPI.getListaContatos(ordenacao: orndenacao, callback: {
            response in
            switch (response.result) {
            case .success( _):
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    guard let data = response.data else {return}
                    print(data)
                    do {
                        self.contatos = try JSONDecoder().decode([ContatoModel].self, from: data)
                        print(self.contatos)
                        self.tableViewContatos.reloadData()
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    
                }
            case .failure(let error):
                
                print(error.localizedDescription)
                break
            }
        })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewContatos.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContatosCell
        
        let contato = self.contatos[indexPath.row]
        
        cell.lbName?.text = contato.name ?? ""
        cell.lbCompany?.text = contato.company ?? ""
        
        let url = URL(string: contato.avatar ?? "")

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.imgAvatar?.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if Internet.isConnected(){
                let contato = self.contatos[indexPath.row]
                deleteContato(id: contato.id ?? "")
                getListaContatos(orndenacao: "sortBy=name&order=asc")
            } else {
                msgInternet()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if Internet.isConnected(){
            let contato = self.contatos[indexPath.row]
            
            var mainView: UIStoryboard!
            mainView = UIStoryboard(name: "InsereAltera", bundle: nil)
            let viewcontroller : Inserir_AlterarViewController = mainView.instantiateViewController(withIdentifier: "InsereAltera") as! Inserir_AlterarViewController
            
            let navControl = UINavigationController(rootViewController: viewcontroller)
            navControl.modalPresentationStyle = .fullScreen
            
            viewcontroller.tipo = "Alterar"
            
            viewcontroller.idContato = contato.id
            viewcontroller.nome = contato.name ?? ""
            viewcontroller.empresa = contato.company ?? ""
            viewcontroller.email = contato.email ?? ""
            viewcontroller.site = contato.website ?? ""
            viewcontroller.fone = contato.phone ?? ""
            viewcontroller.note = contato.customNote ?? ""
            viewcontroller.urlAvatar = contato.avatar ?? ""
            
            self.present(navControl, animated: true, completion: nil)
        } else {
            msgInternet()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}

