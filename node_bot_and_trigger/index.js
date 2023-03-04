const makeWASocket = require("@adiwajshing/baileys").default;
const {
  useMultiFileAuthState,
  DisconnectReason,
} = require("@adiwajshing/baileys");

async function connectToWhatsApp() {
  const { state, saveCreds } = await useMultiFileAuthState("auth_info_baileys");
  const sock = makeWASocket({
    auth: state,
    printQRInTerminal: true,
  });

  sock.ev.on("creds.update", saveCreds);

  sock.ev.on("connection.update", (update) => {
    const { connection, lastDisconnect } = update;
    if (connection === "close") {
      if (typeof lastDisconnect !== "undefined" && lastDisconnect !== null) {
        const shouldReconnect =
          typeof lastDisconnect !== "undefined" &&
          typeof lastDisconnect.error !== "undefined" &&
          typeof lastDisconnect.error.output !== "undefined" &&
          typeof lastDisconnect.error.output.statusCode !== "undefined" &&
          lastDisconnect.error.output.statusCode != DisconnectReason.loggedOut;
        if (shouldReconnect) {
          connectToWhatsApp();
        }
      }
    } else if (connection === "open") {
      console.log("opened connection");
    }
  });
}
// run in main file
connectToWhatsApp();
