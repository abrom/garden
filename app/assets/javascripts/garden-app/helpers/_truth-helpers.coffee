App.EqHelper = Em.Helper.helper (v1, v2)-> v1 == v2
App.NeHelper = Em.Helper.helper (v1, v2)-> v1 != v2
App.LtHelper = Em.Helper.helper (v1, v2)-> v1 < v2
App.GtHelper = Em.Helper.helper (v1, v2)-> v1 > v2
App.LteHelper = Em.Helper.helper (v1, v2)-> v1 <= v2
App.GteHelper = Em.Helper.helper (v1, v2)-> v1 >= v2
App.AndHelper = Em.Helper.helper (v1, v2)-> v1 && v2
App.OrHelper = Em.Helper.helper (v1, v2)-> v1 || v2
App.NotHelper = Em.Helper.helper (v1)-> !v1
App.PresentHelper = Em.Helper.helper (v1)-> !!v1
