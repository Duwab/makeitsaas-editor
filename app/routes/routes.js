module.exports = function(app) {

  app.get('/entities/:entity_name', (req, res) => {
    var model = app.models[req.params.entity_name];
    if(model) {
      model.findAll({
        // attributes: {
        //   include: ['id', 'pattern'],
        // }
      }).then(entities => {
        console.log('values', entities[0].get({plain: true}));
        res.send({values: entities.map(entity => entity.get({plain: true}))});
      });
    } else {
      res.status(404).send({
        status: 'error',
        message: 'Model not found'
      });
    }
  });

}
