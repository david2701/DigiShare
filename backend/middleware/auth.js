const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
  try {
      console.log(req.headers.authorization);
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, 'Digi_Share_RONDOM_SECRET');
    const userId = decodedToken.userId;
    if (req.body.userId && req.body.userId !== userId) {
        console.log("Invalid user ID");
      throw 'Invalid user ID';
    } else {
      next();
    }
  } catch {
    console.log("Invalid request");
    res.status(401).json({
      error: new Error('Invalid request!')
    });
  }
  
};