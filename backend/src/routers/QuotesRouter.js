var express = require("express");
var router = express.Router();
const controller = require("../controllers/QuotesController");

router.get("/", controller.quoteNow);

module.exports = router;
