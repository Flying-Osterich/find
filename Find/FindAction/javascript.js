function TagContentWrapper() {
  var self = this;

	var wrapStringWithWrapper = function(subject, wrapper) {
		wrapper.innerHTML = subject;
		return wrapper.outerHTML;
	}

	this.wrapOccurencesOf = function(subject, wrapperCreator) {
		var wrappedSubject = wrapStringWithWrapper(subject, wrapperCreator());

		var allElements = document.getElementsByTagName('span');
		for (var i = 0; i < allElements.length; ++i) {
			var element = allElements[i];
			element.innerHTML = element.innerHTML.replace(subject, wrappedSubject);
		}
	};
}

var tagContentWrapper = new TagContentWrapper;

var highlightWrapper = function(subject) {
  tagContentWrapper.wrapOccurencesOf(subject, function() {
    return document.createElement("mark");
  });
}

var MyExtensionJavaScriptClass = function() {};
 
MyExtensionJavaScriptClass.prototype = {
    run: function(arguments) {
		arguments.completionFunction({"baseURI" : document.baseURI});
    },
 
    finalize: function(arguments) {
		highlightWrapper(arguments["string"]);
		console.log(document.getElementsByTagName('span'));
    }
};

var ExtensionPreprocessingJS = new MyExtensionJavaScriptClass;
