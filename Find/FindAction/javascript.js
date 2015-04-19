function TagContentWrapper() {
	var self = this;

	var wrapStringWithWrapper = function(subject, wrapper) {
		wrapper.innerHTML = subject;
		return wrapper.outerHTML;
	}

	var replaceOccurencesOfStringWithStringInDocument = function(string, replacementString) {
		var textWrappingTags = ('span', 'p');
		for (var i = 0; i < textWrappingTags.length; ++i) {
			var tag = textWrappingTags[i];
			var allElements = document.getElementsByTagName(tag);
			for (var j = 0; j < allElements.length; ++j) {
				var element = allElements[j];
				element.innerHTML = element.innerHTML.replace(string, replacementString);
			}			
		}
	}

	this.wrapOccurencesOf = function(subject, wrapperCreator) {
		var wrappedSubject = wrapStringWithWrapper(subject, wrapperCreator());
		replaceOccurencesOfStringWithStringInDocument(subject, wrappedSubject)
	};
	
	this.removeWrapperAround = function(tag) {
		var allElements = document.getElementsByTagName(tag);
		for (var i = 0; i < allElements.length; ++i) {
			var element = allElements[i];
			element.outerHTML = element.innerHTML;
		}
	};
}

var tagContentWrapper = new TagContentWrapper;

var highlightWrapper = function(subject) {
	tagContentWrapper.wrapOccurencesOf(subject, function() {
		return document.createElement("mark");
	});
}


var clearHighlight = function() {
	tagContentWrapper.removeWrapperAround("mark")
}


var MyExtensionJavaScriptClass = function() {};

MyExtensionJavaScriptClass.prototype = {
	run: function(arguments) {
		arguments.completionFunction({
			"baseURI": document.baseURI
		});
	},

	finalize: function(arguments) {
		clearHighlight();
		highlightWrapper(arguments["string"]);
	}
};

var ExtensionPreprocessingJS = new MyExtensionJavaScriptClass;
