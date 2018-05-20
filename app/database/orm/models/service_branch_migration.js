/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('service_branch_migration', {
    id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    service_branch_id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'service_branch',
        key: 'id'
      }
    },
    service_migration_id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'service_migration',
        key: 'id'
      }
    },
    applied: {
      type: DataTypes.INTEGER(1),
      allowNull: false,
      defaultValue: '0'
    },
    failed: {
      type: DataTypes.INTEGER(1),
      allowNull: false,
      defaultValue: '0'
    },
    ignore_it: {
      type: DataTypes.INTEGER(1),
      allowNull: false,
      defaultValue: '0'
    },
    pending_request: {
      type: DataTypes.DATE,
      allowNull: true
    }
  }, {
    tableName: 'service_branch_migration',
    timestamps: false
  });
};
