/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('environment', {
    id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    project_id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'project',
        key: 'id'
      }
    },
    subdomain: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    date_create: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    }
  }, {
    tableName: 'environment',
    timestamps: false
  });
};
