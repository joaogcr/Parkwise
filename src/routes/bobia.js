var express = require("express");
var router = express.Router();

var bobiaController = require("../controllers/bobiaController");

router.get("/bobIA", function (req, res) {
    bobiaController.get(req, res);
});

module.exports = router, bobiaController;