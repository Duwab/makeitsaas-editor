/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('service', {
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
    name: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    type: {
      type: DataTypes.ENUM('repository','cdn','database','faas','other'),
      allowNull: false,
      defaultValue: 'repository'
    },
    repository_url: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    position: {
      type: DataTypes.INTEGER(6).UNSIGNED,
      allowNull: false
    },
    date_create: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
    }
  }, {
    tableName: 'service',
    timestamps: false
  });
};
