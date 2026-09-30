const os = require("os")

module.exports = (req, res, next) => {
    if (req.path.startsWith("/auth-header-required")) {
        if (req.get("Authorization") !== "Bearer 123456") {
            res.status(401).send('Invalid Authorization header, try setting it to "Bearer 123456"')
            return
        }
    }

    if (req.path.startsWith("/client-ip")) {
        res.json({ "client-ip": req.connection.remoteAddress });
        return
    }

    if (req.path.startsWith("/hostname")) {
        res.json({ hostname: os.hostname() })
        return
    }

    next()
}
