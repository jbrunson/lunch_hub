'use strict';


angular.module('fakeLunchHubApp')
  .controller('GroupsCtrl', ['$scope', 'Group', function($scope, Group) {
    // $scope.groups = Group.query();
    $scope.groups = ['Group One', 'Group two'];
  }]);