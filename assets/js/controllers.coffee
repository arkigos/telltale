@angular.module('arkh', ['ui.bootstrap'])

@QuizCtrl = ($scope, $resource) ->
    User = $resource '/user/:username',
        username: 'Username'
        password: '@#changeme#@'
        selftype: 'XyXy'
        answered: []
        
    Question = $resource '/quiz/:question',
        question: 'What is your quest?'
        answers: []
        author: 'arkigos'

    $scope.saveSuccess = false
    
    $scope.questions = []
    $http.get('/questions').success (data) ->
        $scope.questions = data
        
    $scope.login = 
        user: ""
        pass: ""
        loggedIn: false
    
    $scope.logIn = () ->
        createUser = () ->
            $http.put('/user/'+, userdata).
        if $scope.login.user
            $http.get('/users/'+$scope.login.user).success (data) ->
                user = data[0]
                if !user
                    
                    console.log('empty array be true')
                
                console.log(data)
                $scope.login.loggedIn = true
    $scope.logOut = () ->
        $scope.login.loggedIn = false
    
    $scope.axes = [
        "Fe"
        "Ti"
        "Fi"
        "Te"
        "Se"
        "Ni"
        "Ne"
        "Si"
    ]
    $scope.question = 
        question: ""
        answers: []
    $scope.answers = [{text: "", chosen: false, indicates: $scope.axes[0]}]
    $scope.saveQuestion = () ->
        $scope.question.answers = $scope.answers
        $scope.questions.push($scope.question)
        $scope.question = 
            question: ""
            answers: []
        $scope.answers = [{text: "", chosen: false, indicates: $scope.axes[0]}]
        $scope.saveSuccess = true
    $scope.addAnswer = () ->
        $scope.answers.push({text: "", chosen: false, indicates: $scope.axes[0]})
    $scope.chooseAnswer = (question, answer) ->
        ans.chosen = false for ans in question.answers
        if answer.chosen
            answer.chosen = false
        else
            answer.chosen = true
    
    $scope.isCollapsed = true

@ModalCtrl = ($scope, $modal) ->
    $scope.items = ['item1', 'item2', 'item3', 'item4']
    $scope.open = () ->
        modalInstance = $modal.open
            templateUrl: "partials/modal"
            controller: ModalStanceCtrl
            resolve:
                items: () ->
                    $scope.items

@ModalStanceCtrl = ($scope, $modalInstance, items) ->
    $scope.items = items
    $scope.selected =
        item: $scope.items[0]
    
    $scope.ok = () ->
        $modalInstance.close $scope.selected.item 
    
    $scope.cancel = () ->
        $modalInstance.dismiss 'cancel'
    
    
    
    
    
    