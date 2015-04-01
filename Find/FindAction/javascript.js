var MyExtensionJavaScriptClass = function() {};
 
MyExtensionJavaScriptClass.prototype = {
    run: function(arguments) {
		arguments.completionFunction({"baseURI" : document.baseURI});
    },
 
    finalize: function(arguments) {
		document.body.style.backgroundColor = arguments["bgColor"];
	
    }
};

var ExtensionPreprocessingJS = new MyExtensionJavaScriptClass;
