const Q = require('q');
const fs = require('fs');

module.exports = function() {
  console.log('sequelize', process.env.DB_HOSTNAME, process.env.DB_DATABASE, process.env.DB_USERNAME, process.env.DB_PASSWORD);
  const Sequelize = require('sequelize');
  const sequelize = new Sequelize(process.env.DB_DATABASE, process.env.DB_USERNAME, process.env.DB_PASSWORD, {
    host: process.env.DB_HOSTNAME,
    port: process.env.DB_PORT,
    dialect: 'mysql',
    // dialect: 'mysql'|'sqlite'|'postgres'|'mssql',
    operatorsAliases: false,
    additional: {
        timestamps: false
        //...
    },

    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000
    }
  });

  // test connection
  let testConnection = sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
    throw new Error('listId does not exist');
  });



  let models = {
    // Entity: sequelize.define('entity',require('./models/entity'))
  };

  fs.readdir(__dirname + '/models', function(err, items) {
    console.log(err, items);
    items.map(fileName => {
      let entityName = fileName.replace(/^(.*)\.js$/, '$1');
      models[entityName] = require(`./models/${entityName}`)(sequelize, Sequelize.DataTypes)
    })
    for (var i=0; i<items.length; i++) {
        console.log(items[i]);
    }
});

  let syncs = [testConnection];

  for(let key in models) {
    syncs.push(models[key].sync());
  }

  return Q.all(syncs).then(() => models);

}
