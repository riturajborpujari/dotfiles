const { exec, execSync } = require("child_process");
const net = require("net");
const fs = require("fs");

const socketAddress = `${process.env.XDG_RUNTIME_DIR}/hypr/${process.env.HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock`;
const logFile = `${process.env.HOME}/.config/hypr/hypr_tracker.log`

const client = net.createConnection(socketAddress);
const logStream = fs.createWriteStream(logFile, { encoding: "utf-8" });

function log(...items) {
    logStream.write(`${new Date().toISOString()}: ${items.join(" : ")}\n`)
}

let activeWorkspaces = new Set(["1"]);
let currentWorkspace = "1";
let currentWindow = "{}";
let specialWorkspace = false;
let currentWorkspaceBehindSpecial = "1";

client.on("data", (chunk) => {
    const events = chunk
        .toString()
        .split("\n")
        .filter((el) => el.length);
    events.forEach((event) => {
        if (event.startsWith("activewindow>>")) {
            let [program, title] = event.substr(14).split(",");
            title = title.replace("'", "՚")
            currentWindow = { program, title };
            return;
        }
        if (event.startsWith("workspace>>")) {
            const workspace = event.substr(11, 13)
            log("workspace", workspace)
            if (!specialWorkspace) {
                currentWorkspace = workspace;
            } else {
                currentWorkspaceBehindSpecial = workspace
            }
            activeWorkspaces.add(workspace)
            return;
        }
        if (event.startsWith("createworkspace>>")) {
            const workspace = event.substr(17)
            activeWorkspaces.add(workspace)
            return;
        }
        if (event.startsWith("destroyworkspace>>")) {
            const workspace = event.substr(18)
            activeWorkspaces.delete(workspace)
            return;
        }
        if (event.startsWith("activespecial>>")) {
            const workspace = event.substring(15, event.indexOf(","))
            if (workspace != "") {
                currentWorkspace = workspace;
                specialWorkspace = true;
            } else {
                specialWorkspace = false;
                currentWorkspace = currentWorkspaceBehindSpecial
            }
            return
        }
    });

    const workspaces = []
    for (const ws of activeWorkspaces.values()) {
        workspaces.push(ws)
    }
    hyprTrackerStats = JSON.stringify({
        activeWorkspaces: workspaces,
        currentWorkspace,
        currentWindow,
    });
    try {
        execSync(`eww update hyprTrackerStats='${hyprTrackerStats}'`)
        log("exec", `eww update hyprTrackerStats='${hyprTrackerStats}'`)
    } catch (err) {
        console.log(err)
    }
});
