/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('service_migration', {
    id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    service_id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'service',
        key: 'id'
      }
    },
    type: {
      type: DataTypes.ENUM('SQL','git'),
      allowNull: false
    },
    content: {
      type: DataTypes.TEXT,
      allowNull: false
    }
  }, {
    tableName: 'service_migration',
    timestamps: false
  });
};
