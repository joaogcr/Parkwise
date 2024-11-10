var express = require("express");
var router = express.Router();

router.get("/Site/", function (req, res) {
    res.render("index");
});

module.exports = router;