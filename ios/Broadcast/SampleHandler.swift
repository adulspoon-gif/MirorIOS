import ReplayKit

final class SampleHandler: RPBroadcastSampleHandler {
    private let server = StreamServer(port: 8765)   // harus sama dengan DEVICE_PORT di Windows
    private let encoder = H264Encoder()

    override func broadcastStarted(withSetupInfo setupInfo: [String: NSObject]?) {
        encoder.onFrame = { [weak self] data, key, orient in self?.server.send(data, key: key, orient: orient) }
        server.onNeedKeyFrame = { [weak self] in self?.encoder.requestKeyFrame() }
        do { try server.start() } catch {
            finishBroadcastWithError(NSError(domain: "MirrorUSB", code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Gagal membuka port 8765: \(error.localizedDescription)"]))
        }
    }

    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        if sampleBufferType == .video { encoder.encode(sampleBuffer) }
    }

    override func broadcastFinished() {
        server.stop()
        encoder.stop()
    }
}
