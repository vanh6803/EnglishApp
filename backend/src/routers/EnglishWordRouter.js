var express = require("express");
var router = express.Router();
const controller = require("../controllers/EnglishWordController");

router.get("/random", controller.getWordRandomToday);
router.get("/", controller.getAllWord);

module.exports = router;
