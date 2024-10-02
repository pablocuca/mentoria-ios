import Foundation

class CountdownUseCase {
    private var countdownValue: Int
    private let totalDuration: Int
    private var timer: Timer?
    private var completion: ((Int, Bool) -> Void)?

    init(startValue: Int = 10) {
        self.countdownValue = startValue
        self.totalDuration = startValue
    }

    func startCountdown(completion: @escaping (Int, Bool) -> Void) {
        self.completion = completion
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc private func updateCountdown() {
        if countdownValue > 0 {
            completion?(countdownValue, false)
            countdownValue -= 1
        } else {
            timer?.invalidate()
            timer = nil
            completion?(0, true)
        }
    }

    func stopCountdown() {
        timer?.invalidate()
        timer = nil
    }
}
