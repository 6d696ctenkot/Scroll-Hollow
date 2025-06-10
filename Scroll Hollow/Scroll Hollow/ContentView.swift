import SwiftUI
import AVFoundation

struct ScrollHollowView: View {
    @State private var glitchLines = (0..<50).map { _ in UUID() }
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(glitchLines, id: \.self) { _ in
                        GlitchCardView()
                    }
                }
                .padding()
            }

            VStack {
                Spacer()
                Text("Still here?")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.1))
                    .padding(.bottom, 30)
            }
        }
        .onAppear {
            playBackgroundNoise()
        }
    }

    func playBackgroundNoise() {
        guard let url = Bundle.main.url(forResource: "digital_noise", withExtension: "wav") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0.2
            audioPlayer?.play()
        } catch {
            print("Failed to load sound.")
        }
    }
}

struct GlitchCardView: View {
    @State private var glitchText: String = GlitchCardView.generateGlitchText()

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white.opacity(0.05))
            .frame(height: 100)
            .overlay(
                Text(glitchText)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.3))
                    .multilineTextAlignment(.center)
                    .padding()
            )
            .onTapGesture {
                glitchText = GlitchCardView.generateGlitchText()
            }
    }

    static func generateGlitchText() -> String {
        let phrases = [
            "▇▇▇ LOADING ▇▇▇",
            "[404] Missing Thought",
            "_ . . .",
            "You liked this — maybe.",
            "NULL.",
            "∅ Reward",
            "..."
        ]
        return phrases.randomElement() ?? ""
    }
}
