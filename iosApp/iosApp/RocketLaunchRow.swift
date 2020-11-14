
import SwiftUI
import shared

struct RocketLaunchRow: View {
    var rocketLaunch: RocketLaunch

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10.0) {
                Text("Launch name: \(rocketLaunch.missionName)")
                Text(launchText).foregroundColor(launchColor)
                Text("Launch year: \(String(rocketLaunch.launchYear))")
                Text("Launch details: \(rocketLaunch.details ?? "")")
            }
            Spacer()
        }
    }
}

extension RocketLaunchRow {
    private var launchText: String {
        guard let isSuccess = rocketLaunch.launchSuccess else {
            return "No data"
        }
        return isSuccess.boolValue ? "Successful" : "failed"
    }

    private var launchColor: Color {
        guard let isSuccess = rocketLaunch.launchSuccess else {
            return .gray
        }
        return isSuccess.boolValue ? .green : .red
    }
}

struct RocketLaunchRow_Previews: PreviewProvider {
    static var previews: some View {
        RocketLaunchRow(rocketLaunch: RocketLaunch(
            flightNumber: 123,
            missionName: "mission1",
            launchYear: 1992, launchDateUTC: "",
            rocket: Rocket(id: "1234", name: "name", type: "type1"),
            details: "",
            launchSuccess: true,
            links: Links(missionPatchUrl: "http://mision.com", articleUrl: "http://article.com")))
    }
}
