const os = require("os")

const hostname = os.hostname()

module.exports = (req, res, next) => {
    const requestPath = req.path || ""

    if (requestPath.startsWith("/auth-header-required")) {
        if (req.get("Authorization") !== "Bearer 123456") {
            res.status(401).send('Invalid Authorization header, try setting it to "Bearer 123456"')
            return
        }
    }

    if (requestPath.startsWith("/client-ip")) {
        res.json({ "client-ip": req.socket.remoteAddress })
        return
    }

    if (requestPath.startsWith("/hostname")) {
        res.json({ hostname })
        return
    }

    next()
}
