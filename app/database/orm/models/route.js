/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('route', {
    id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    domain_id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: 'domain',
        key: 'id'
      }
    },
    parent_route_id: {
      type: DataTypes.BIGINT,
      allowNull: true,
      references: {
        model: 'route',
        key: 'id'
      }
    },
    target_service_id: {
      type: DataTypes.BIGINT,
      allowNull: true,
      references: {
        model: 'service',
        key: 'id'
      }
    },
    pattern: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    position: {
      type: DataTypes.INTEGER(6).UNSIGNED,
      allowNull: false
    },
    date_create: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    },
    date_update: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    }
  }, {
    tableName: 'route',
    timestamps: false
  });
};
