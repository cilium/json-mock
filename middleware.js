const os = require("os")
const compression = require("compression")
const compress = compression()

module.exports = (req, res, next) => {
    // Apply compression first, then proceed with the existing middleware logic
    compress(req, res, () => {
        if (req.path.startsWith("/auth-header-required")) {
            if (req.get("Authorization") !== "******") {
                res.status(401).send('Invalid Authorization header, try setting it to "******"')
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
    })
}
