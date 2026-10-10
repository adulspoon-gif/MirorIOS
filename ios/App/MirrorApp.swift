import SwiftUI
import ReplayKit

@main
struct MirrorApp: App {
    var body: some Scene { WindowGroup { ContentView() } }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Mirror USB").font(.largeTitle.bold())
            Text("1. Colok kabel USB ke PC dan buka MirrorUSB di Windows\n2. Tekan ikon di bawah → pilih “Mirror USB” → Start Broadcast")
                .multilineTextAlignment(.center)
            BroadcastPicker().frame(width: 96, height: 96)
            Text("Untuk berhenti: tekan status bar merah / ikon rekam layar di Control Center.")
                .font(.footnote).foregroundColor(.secondary).multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct BroadcastPicker: UIViewRepresentable {
    func makeUIView(context: Context) -> RPSystemBroadcastPickerView {
        let v = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0, width: 96, height: 96))
        // Bundle ID extension = bundle ID app + ".broadcast" (tetap benar walau di-resign 3uTools/Sideloadly)
        v.preferredExtension = (Bundle.main.bundleIdentifier ?? "") + ".broadcast"
        v.showsMicrophoneButton = false
        return v
    }
    func updateUIView(_ uiView: RPSystemBroadcastPickerView, context: Context) {}
}
