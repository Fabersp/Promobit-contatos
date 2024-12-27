
# 📱 **Promobit-Contacts**

**Promobit-Contacts** is an iOS application developed in **Swift** with integration to the **MockAPI** service. It enables contact management, including listing, creating, updating, and deleting contacts, with a user-friendly and intuitive interface.

---

## 🚀 **Overview**

**Promobit-Contacts** is an app designed to simplify contact management with features such as:

- **📄 Contact Listing:** Displays a list of contacts with details such as name, company, and avatar.
- **➕ Add Contacts:** Allows adding new contacts.
- **📝 Edit Contacts:** Updates existing contact information.
- **❌ Delete Contacts:** Removes selected contacts.
- **🔍 Smart Filters:** Sorting by name and company (A-Z, Z-A).
- **🌐 Internet Connection Verification:** Ensures connectivity before performing critical operations.

---

## 🛠️ **Technologies Used**

### **Language:**
- **Swift 5**

### **Frameworks:**
- **UIKit**
- **Alamofire** (for API calls)
- **SWRevealViewController** (for side menu)
- **Reachability** (for connectivity monitoring)

### **Architecture:**
- **MVC (Model-View-Controller)**

---

## 📂 **Project Structure**

```
Promobit-Contacts/
│── Internet/
│   ├── Reachability.swift
│── Delegates/
│   ├── SceneDelegate.swift
│   ├── AppDelegate.swift
│── Models/
│   ├── ContatoModel.swift
│── Views/
│   ├── LaunchScreen.storyboard
│   ├── Main.storyboard
│   ├── InsereAltera.storyboard
│── Controllers/
│   ├── ViewController.swift
│   ├── ContatosCell.swift
│   ├── Inserir_AlterarViewController.swift
│── Drawer/
│   ├── SidebarViewController.swift
│   ├── SWRevealViewController.swift
│── Services/
│   ├── RestAPI.swift
│── Assets/
│   ├── Images/
│── Info.plist
```

---

## ⚙️ **Installation and Setup**

### **Prerequisites:**
- **Xcode 14+**
- **Swift Package Manager**
- Active internet connection

### **Steps:**

1. **Clone the repository:**  
   ```bash
   git clone https://github.com/fabersp/promobit-contacts.git
   cd Promobit-Contacts
   ```

2. **Install dependencies:**  
   ```bash
   pod install
   ```

3. **Open the project in Xcode:**  
   ```bash
   open Promobit-Contacts.xcworkspace
   ```

4. **Run the project:**  
   - Select a simulator or physical device.  
   - Press **Cmd + R** to run.  

---

## 📲 **Key Features**

### **1. Contact Listing**
- Displays a contact list with names, company details, and avatars.  
- Sorting by **Name** and **Company** in both **Ascending** and **Descending** orders.  

### **2. Add Contacts**
- Add new contacts with details like name, phone number, email, website, and custom notes.

### **3. Edit Contacts**
- Update existing contact information.

### **4. Delete Contacts**
- Remove contacts directly from the list.

### **5. Smart Sorting Filters**
- **Name (A-Z / Z-A)**  
- **Company (A-Z / Z-A)**  

### **6. Side Menu Navigation**
- Easy access to main functionalities via a side menu using **SWRevealViewController**.

---

## 📡 **API Integration**

The project uses **MockAPI** as the backend for contact management.

### **Endpoints:**

- **List Contacts:** `GET /api/contatos`  
- **Add Contact:** `POST /api/contatos`  
- **Update Contact:** `PUT /api/contatos/{id}`  
- **Delete Contact:** `DELETE /api/contatos/{id}`  

**Example GET Request with Alamofire:**

```swift
RestAPI.getListaContatos(ordenacao: "sortBy=name&order=asc") { response in
    switch response.result {
    case .success(let data):
        print("Contacts loaded successfully:", data)
    case .failure(let error):
        print("Failed to load contacts:", error.localizedDescription)
    }
}
```

---

## 🧑‍💻 **Developers**

- **Lead Developer:** Fabricio Aguiar de Padua
- **LinkedIn:** www.linkedin.com/fabricio-padua  
- **contact:** fabricio_0505_@hotmail.com

---

## 📜 **License**

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

---

**Ready to manage your contacts effortlessly? 🚀**

