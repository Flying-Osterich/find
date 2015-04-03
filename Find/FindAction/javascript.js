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
			var regularExpression = new RegExp(String(subject));
			var splitResults = element.innerHTML.split(regularExpression);
			if (splitResults.length > 1) {
				for (var j = 0; j < splitResults.length; ++j) {
					if (j % 2 == 0) {
						var newString = splitResults[j] + wrappedSubject + splitResults[j+1];
						element.innerHTML = newString;
					}
				}
			}
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
