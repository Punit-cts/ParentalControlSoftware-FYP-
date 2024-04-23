

import SwiftUI

struct OtpView: View {
    @State  var otpText = ""
    @State  var expectedOTP: String?
    @EnvironmentObject var redirectionModel: RedirectionModel
    @State  var showAlert = false // Add state for showing alert

    var body: some View {
        VStack(alignment: .leading) {
            Text("Verify OTP")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color(red: 0.12688566209999999, green: 0.31438164229999999, blue: 0.64497422680000005))
            
            Text("A six-numbered OTP will be delivered")
                .font(.system(size: 14))
                .foregroundColor(Color(white: 0.33333333329999998))
                .padding(.top, 8)
            
            Spacer().frame(height: 40)
            
            TextField("", text: $otpText)
                .frame(height: 100)
                .font(.system(size: 55))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .background(.white)
            
            Button(action: {
                verifyOTP()
            }) {
                Text("Verify OTP")
                    .font(.system(size: 17))
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 32)
                    .padding(.top, 50)
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
        .background(Color(red: 0.81346767070000003, green: 0.99063362880000005, blue: 1))
        .navigationBarTitle("Enter OTP", displayMode: .inline)
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid OTP"), message: Text("Please enter a valid OTP."), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            scheduleRandomNotification()
        }
    }
    
    func scheduleRandomNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Your OTP"
        let randomOTP = "\(Int.random(in: 100000...999999))"
        content.body = randomOTP
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
                expectedOTP = randomOTP
            }
        }
    }
    
    func verifyOTP() {
        guard let expectedOTP = expectedOTP else {
            print("Expected OTP not set")
            return
        }
        
        if otpText == expectedOTP {
            redirectionModel.changeCurrentView = .dashboard
        } else {
            showAlert = true // Show alert for invalid OTP
        }
    }
}

#Preview {
    OtpView()
}
