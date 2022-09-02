let hub;
let websocket;
let connectedPlugin = false;
let connectedHub = false;
let lastPing = 0;
let intervalHeartbeat;
let voip = {};
let talkState = [];
let apiUrl = "";

async function init() {
  try {
    await createHub();
    await createWebSocket();
    startHeartbeat();
  } catch {
    await init();
  }
}

async function createHub() {
  try {
    const options = {
      skipNegotiation: true,
      transport: signalR.HttpTransportType.WebSockets,
    };
    // if (hub && hub.connectionState == "Connected") await hub.stop();
    if (hub && hub.connectionState == "Connected") return;

    const timeout = [0, 1000, 2000, 3000, 4000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 50000, 60000];
    hub = new signalR.HubConnectionBuilder()
      .withUrl(`${apiUrl}hub/voip`, options)
      .withAutomaticReconnect(timeout)
      .configureLogging(signalR.LogLevel.None)
      .build();
    //hub = new signalR.HubConnectionBuilder().withUrl(`http://177.54.149.160/hub/voip`, options).withAutomaticReconnect().configureLogging(signalR.LogLevel.None).build();
    await hub.start();
    connectedHub = true;
    hub.on("SendToPlugin", sendToPlugin);
    hub.on("ClientSyncEvent", clientSyncEvent);
    hub.on("SyncBlips", syncBlips);
    hub.onreconnecting((error) => {
      console.error(
        `Conexão perdida com hub voip: "${error}". Reconectando....`
      );
    });

    hub.onreconnected(() => {
      console.log(`Conexão reestabelecida com hub inventory. Conectado!`);
    });

  } catch {
    setTimeout(createHub, 5000);
  }
}

function createWebSocket() {
  return new Promise((resolve, reject) => {
    websocket = new WebSocket("ws://127.0.0.1:38204/drkz");

    websocket.onopen = () => {
      lastPing = getTickCount();
      connectedPlugin = true;
      resolve();
    };

    websocket.onmessage = (evt) => {
      if (evt.data.includes("TokoVOIP status:")) {
        connectedPlugin = true;
        lastPing = getTickCount();
        voip.pluginStatus = evt.data.split(":")[1].replace(/\./g, "");
      }

      if (evt.data.includes("TokoVOIP UUID:")) {
        voip.pluginUUID = evt.data.split(":")[1];
      }

      if (evt.data == "startedtalking") {
        post("onSetTalking", { value: true });
      }

      if (evt.data == "stoppedtalking") {
        post("onSetTalking", { value: false });
      }
    };

    websocket.onclose = () => {
      connectedPlugin = false;
      reject();
    };
  });
}

function startHeartbeat() {
  if (intervalHeartbeat) clearInterval(intervalHeartbeat);
  intervalHeartbeat = setInterval(async () => {
    if (!connectedPlugin || getTickCount() - lastPing > 5000) {
      connectedPlugin = false;
    }

    if (!hub || hub.connectionState != "Connected") {
      connectedHub = false;
    }

    if (!connectedPlugin || !connectedHub) await init();
  }, 5000);
}

function getTickCount() {
  return new Date().getTime();
}

function receivedClientCall(event) {
  const eventName = event.data.type;
  let payload = event.data.detail;

  if (voip.pluginStatus == -1) return;

  if (eventName == "connect") {
    apiUrl = payload;
    init();
  }

  if (eventName == "characterData")
    invoke("UpdateCharacterData", {
      pluginUUID: voip.pluginUUID,
      ...payload,
    });

  if (eventName == "triggerSyncEvent") invoke("TriggerSyncEvent", JSON.stringify(payload));
}

function post(url, data) {
  //console.log('post => ' + JSON.stringify(data));
  $.post("http://voip/" + url, typeof data === "string" ? data : JSON.stringify(data));
}

function invoke(method, data) {
  if (hub && hub.connectionState == "Connected") {
    hub.invoke(method, data);
  } else {
    connectedHub = false;
  }
}

function sendToPlugin(data) {
  const jObject = JSON.parse(data);
  const hasDiference =
    talkState.length != jObject.Users.length ||
    jObject.Users.some((x) => !talkState.some((t) => t.playerServerId == x.playerServerId && t.talking == x.talking));

  if (hasDiference) {
    talkState = jObject.Users.map((x) => {
      return {
        playerServerId: x.playerServerId,
        talking: x.talking,
      };
    });
    post("onPluginData", data);
  }

  if (websocket.readyState == websocket.OPEN) {
    websocket.send(data);
  } else {
    connectedPlugin = false;
  }
}

function clientSyncEvent(data) {
  post("ClientSyncEvent", data);
}

function syncBlips(blipsInfo){
  post("SyncBlips", blipsInfo);
}

window.addEventListener("message", receivedClientCall, false);

setTimeout(() => {
  post("onInit", { value: true });
}, 0);
