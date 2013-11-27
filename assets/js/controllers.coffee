@angular.module('arkh', ['ui.bootstrap', 'ui.tinymce.inline', 'xeditable', 'textAngular'])
    .run (editableOptions) ->
        editableOptions.theme = 'bs3'

@EditorCtrl = ($scope, $http) ->
    $scope.siteState = "Login"
    $scope.thisBook = {}
    $scope.thisBookIndex = -1
    $scope.thisChapter = 
        title: "Hello, nurse!"
        content: "Select something, noob."
    $scope.thisChapterTitle = "Placeholder"
    $scope.auth =
        loggedIn: false
    $scope.user = {}
    $scope.reginput =
        user: ""
        email: ""
        pass: ""
        books: []
    $scope.loginput =
        user: ""
        pass: ""
    $scope.addChapter = () ->
        $http
            .put('/save/chapters', {content: "<p>Start writing!!</p>"})
            .success (data) ->
                $scope.user.books[$scope.thisBookIndex].chapters.push
                    title: "New Chapter Title - click to Edit"
                    id: data._id
                $scope.saveUser()
    $scope.saveChapter = () ->
        $scope.thisChapter.id = $scope.thisChapter._id
        $http
            .put('/updatebyid/chapters', $scope.thisChapter)
            .success (data) ->
                console.log(data)
    $scope.editChapter = (index) ->
        theChap = $scope.user.books[$scope.thisBookIndex].chapters[index]
        $http
            .get('/get/chapters/id/'+theChap.id)
            .success (data) ->
                $scope.thisChapterTitle = theChap.title
                $scope.thisChapter = data
    $scope.editBook = (index) ->
        $scope.thisBook = $scope.user.books[index]
        $scope.thisBookIndex = index
        $scope.changeState("Editor")
    $scope.changeState = (state) ->
        $scope.siteState = state
    $scope.login = () ->
        $http
            .get('/get/users/user/'+$scope.loginput.user)
            .success (data) ->
                $scope.auth.loggedIn = true
                $scope.user = data
                $scope.siteState = "Dashboard"
    $scope.addBook = () ->
        $scope.user.books.push
            title: "New Title - click to change"
            genre: ""
            chapters: []
    $scope.saveUser = () ->
        $http
            .put('/save/users', $scope.user)
            .success (data) ->
                console.log(data)
    $scope.removeBook = (index) ->
        if confirm("That will permanently remove this book!!!!!! Are you sure?")
            $scope.user.books.splice(index)
            $scope.saveUser()
    $scope.register = () ->
        regi = $scope.reginput
        if regi.user && regi.email && regi.pass
            $http
                .put("/save/users", $scope.reginput)
                .success (data) ->
                    $scope.user = data
                    console.log($scope.user)
                    $scope.login()

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
