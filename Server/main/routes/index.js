var express = require('express')
var router = express.Router()
var pool = require('../db')

//imports routes for manager
let manager = require('./manager');
router.use('/manager', manager);
//imports routes for rider
let rider = require('./rider');
router.use('/rider', rider);
//imports routes for restaurant
let restaurant = require('./restaurant');
router.use('/restaurant', restaurant);
//imports routes for customer
let customer = require('./customer');
router.use('/customer', customer);

/*specify api path*/
router.get('/hello', (req, res) => {
  res.status(200).send({ message: 'Connected!' });
});


/*
  USER PROFILE SECTION
*/

router.post('/api/posts/userprofiletodb', (req, pres, next) => {
  const values = [
    req.body.password,
    req.body.email,
    req.body.name
  ]
  let queryText1 = "";
  let queryText2 = ""
  switch(req.body.userType) {
    case 'rider':
      queryText1 = `INSERT INTO riders(rid) VALUES($1) RETURNING rid`;
      queryText2 = (req.body.riderType === "FTRiders") ? `INSERT INTO FTRiders(rid) VALUES($1)` : `INSERT INTO PTRiders(rid) VALUES($1)`
      break;
    case 'staff':
      queryText1 = `INSERT INTO staffs(rname, stid) VALUES($1, $2)`
      break;
    default:
      queryText1 = (req.body.userType === "customer") ? `INSERT INTO customers(cid) VALUES($1)`:`INSERT INTO managers(mid) VALUES($1)`
  }

  (async () => {
    const client = await pool.connect();
    try {
      await client.query('BEGIN')
      const res = await client.query(`INSERT INTO Users(password, email, name)
                                      VALUES($1, $2, $3) 
                                      ON CONFLICT DO NOTHING
                                      RETURNING id`, values)
      console.log(res);
      let message = "Your account already exists. Try login!";
      if (res.rowCount !== 0) {
        message = "Signup success!"
        //insert into staff/customer/manager/rider table
        const values1 = (req.body.userType === "staff") ? [req.body.selectedRestaurant, res.rows[0].id] : [res.rows[0].id];
        await client.query(queryText1, values1)
        //insert into part-time/full-time rider
        if(req.body.userType === "rider") {
          await client.query(queryText2, [res.rows[0].id]);
        }
      }
      await client.query('COMMIT').then(pres.send({ message: message }))
    } catch (e) {
      await client.query('ROLLBACK').then(pres.send({ message: "Signup failed :("}))
      throw e
    } finally {
      client.release();
    }
  })().catch(e => console.error(e.stack));
})


router.get('/api/get/userprofilefromdb', (req, res, next) => {
  let queryText = "";
  switch(req.query.userType) {
    case 'customer':
      queryText = `SELECT id, name, email 
      FROM users
      WHERE email=$1 AND password=$2
      AND exists(
        SELECT 1
        FROM customers
        WHERE cid = id
      );`
      break;
    case 'staff':
      queryText = `SELECT id, name, email 
      FROM users
      WHERE email=$1 AND password=$2
      AND exists(
        SELECT 1
        FROM staffs
        WHERE stid = id
      );`
      break;
    case 'rider':
      queryText = `SELECT id, name, email 
      FROM users
      WHERE email=$1 AND password=$2
      AND exists(
        SELECT 1
        FROM riders
        WHERE rid = id
      );`
      break;
    case 'manager':
      queryText = `SELECT id, name, email 
      FROM users
      WHERE email=$1 AND password=$2
      AND exists(
        SELECT 1
        FROM managers
        WHERE mid = id
      );`
      break;
  }
  const email = req.query.email;
  const password = req.query.password;
  if(queryText !== null) {
    pool.query(queryText, [email, password],
      (q_err, q_res) => {
        if (q_res.rowCount !== 0) {
        res.json(q_res.rows);
        } //Is there a better way to show if not found? currently if rows empty then means no account
        else {
          res.json();
        }
      })
  } else {
    res.json();
  }
})

module.exports = router