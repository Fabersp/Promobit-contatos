//
//  Inserir+AlterarViewController.swift
//  Promobit-Contatos
//
//  Created by Monitora on 22/04/21.
//

import UIKit

class Inserir_AlterarViewController: UIViewController {
    
    var urlAvatar : String?
    var nome : String?
    var site : String?
    var fone : String?
    var email : String?
    var empresa : String?
    var note : String?
    var idContato : String?
    
    var tipo : String!
    
    @IBOutlet weak var lbNome: UITextField!
    @IBOutlet weak var ImgAvatar: UIImageView!
    @IBOutlet weak var lbSite: UITextField!
    @IBOutlet weak var lbFone: UITextField!
    @IBOutlet weak var lbEmail: UITextField!
    @IBOutlet weak var lbEmpresa: UITextField!
    @IBOutlet weak var TxvNote: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
        ImgAvatar?.layer.borderWidth = 0.5
        ImgAvatar?.layer.masksToBounds = false
        ImgAvatar?.layer.borderColor = UIColor.black.cgColor
        ImgAvatar?.layer.cornerRadius = (ImgAvatar?.frame.height)!/2
        ImgAvatar?.clipsToBounds = true
        
        if tipo == "Alterar" {
            lbNome.text = nome
            lbFone.text = fone
            lbEmail.text = email
            lbSite.text = site
            lbEmpresa.text = empresa
            TxvNote.text = note

            let url = URL(string: urlAvatar ?? "")
            if url != nil {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        self.ImgAvatar.image = UIImage(data: data!)
                    }
                }
            }
        }
        
    }
    
    @IBAction func btnFechar(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func btnSalvar(_ sender: Any) {
        
        if tipo == "Alterar" {
            UpdateGListComent()
        } else {
            SetGListComent()
        }
    }
    
    func UpdateGListComent() {
        
        
        let param = ["name":"\(lbNome.text ?? "")",
                     "company":"\(lbEmpresa.text ?? "")",
                     "email":"\(lbEmail.text ?? "")",
                     "phone":"\(lbFone.text ?? "")",
                     "website":"\(lbSite.text ?? "")",
                     "custom_note":"\(TxvNote.text ?? "")"]
        
        guard let id = idContato else { return }
        
        RestAPI.updateContato(id: id, body: param, callback: {
            response in
            
            switch (response.result) {
            case .success( _):
                if response.response?.statusCode == 200 ||  response.response?.statusCode == 201  {
                    self.dismiss(animated: true, completion:nil)
                } else {
                    print("Erro ao Alterar")
                }
                
            case .failure(let error):
                
                print(error.localizedDescription)
                break
            }
            
        })
        
    }
    
    func SetGListComent() {
        
        let param = ["name":"\(lbNome.text ?? "")",
                     "company":"\(lbEmpresa.text ?? "")",
                     "email":"\(lbEmail.text ?? "")",
                     "phone":"\(lbFone.text ?? "")",
                     "website":"\(lbSite.text ?? "")",
                     "custom_note":"\(TxvNote.text ?? "")"]
        
        RestAPI.postContato(body: param, callback: {
            response in
            
            switch (response.result) {
            case .success( _):
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    self.dismiss(animated: true, completion:nil)
                } else {
                    print("Erro ao Inserir")
                }
                
            case .failure(let error):
                
                print(error.localizedDescription)
                break
            }
            
        })
        
    }
    
}
