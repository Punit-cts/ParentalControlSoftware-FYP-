////
////  ScreenTimeSelectView.swift
////  Parental Control
////
////  Created by Amrit Duwal on 4/19/24.
////
//
//import SwiftUI
//import DeviceActivity
//
//class ScreenTimeSelectAppsModel: ObservableObject {
//    @Published var activitySelection = FamilyActivitySelection()
//
//    init() { }
//}
//
//
//struct ScreenTimeSelectAppsContentView: View {
//
//    @State private var pickerIsPresented = false
//    @ObservedObject var model: ScreenTimeSelectAppsModel
//
//    var body: some View {
//        Button {
//            pickerIsPresented = true
//        } label: {
//            Text("Select Apps")
//        }
//        .familyActivityPicker(
//            isPresented: $pickerIsPresented,
//            selection: $model.activitySelection
//        )
//    }
//}
//
//
//class SomeViewController: UIViewController {
//
//    // ...
//    
//    let model = ScreenTimeSelectAppsModel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let rootView = ScreenTimeSelectAppsContentView(model: model)
//        
//        let controller = UIHostingController(rootView: rootView)
//        addChild(controller)
//        view.addSubview(controller.view)
//        controller.view.frame = view.frame
//        controller.didMove(toParent: self)
//    }
//    
//    // ...
//}
//
//class SomeView1Controller: UIViewController {
//
//    // ...
//    
//    private var cancellables = Set<AnyCancellable>()
//    
//    // Used to encode codable to UserDefaults
//    private let encoder = PropertyListEncoder()
//
//    // Used to decode codable from UserDefaults
//    private let decoder = PropertyListDecoder()
//
//    private let userDefaultsKey = "ScreenTimeSelection"
//
//    override func viewDidLoad() {
//    
//        // ...
//        
//        // Set the initial selection
//        model.activitySelection = savedSelection ?? FamilyActivitySelection()
//        
//        model.$activitySelection.sink { selection in
//            self.saveSelection(selection: selection)
//        }
//        .store(in: &cancellables)
//    }
//    
//    func saveSelection(selection: FamilyActivitySelection) {
//    
//        let defaults = UserDefaults.standard
//
//        defaults.set(
//            try? encoder.encode(selection),
//            forKey: userDefaultsKey
//        )
//    }
//    
//    func savedSelection() -> FamilyActivitySelection? {
//        let defaults = UserDefaults.standard
//
//        guard let data = defaults.data(forKey: userDefaultsKey) else {
//            return nil
//        }
//
//        return try? defaults.decode(
//            FamilyActivitySelection.self,
//            data
//        )
//    }
//    
//    // ...
//}
//
//
////struct ScreenTimeSelectView: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
////
////#Preview {
////    ScreenTimeSelectView()
////}
