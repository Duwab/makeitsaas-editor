/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('domain', {
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
    pattern: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    position: {
      type: DataTypes.INTEGER(6).UNSIGNED,
      allowNull: false,
      defaultValue: '0'
    },
    date_create: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    }
  }, {
    tableName: 'domain',
    timestamps: false
  });
};
