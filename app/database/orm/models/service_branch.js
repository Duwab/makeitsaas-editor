/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('service_branch', {
    id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    cluster_reference_id: {
      type: DataTypes.STRING(255),
      allowNull: false,
      unique: true
    },
    environment_id: {
      type: DataTypes.BIGINT,
      allowNull: true,
      references: {
        model: 'environment',
        key: 'id'
      }
    },
    service_id: {
      type: DataTypes.BIGINT,
      allowNull: true,
      references: {
        model: 'service',
        key: 'id'
      }
    }
  }, {
    tableName: 'service_branch',
    timestamps: false
  });
};
