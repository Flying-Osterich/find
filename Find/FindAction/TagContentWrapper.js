function TagContentWrapper() {
	var self = this;

	var wrapStringWithWrapper = function(subject, wrapper) {
		wrapper.innerHTML = subject;
		return wrapper.outerHTML;
	}

	var replaceOccurencesOfStringWithStringInDocument = function(string, replacementString) {
		var allElements = document.getElementsByTagName('span');
		for (var i = 0; i < allElements.length; ++i) {
			var element = allElements[i];
			element.innerHTML = element.innerHTML.replace(string, replacementString);
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

clearHighlight();
highlightWrapper(arguments["%@"]);
