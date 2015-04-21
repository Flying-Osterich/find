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
	
	var strip = function(html)
	{
	   var tmp = document.createElement("DIV");
	   tmp.innerHTML = html;
	   console.log(tmp)
	   console.log(tmp.textContent)
	   console.log(tmp.innerText)
	   return tmp.textContent || tmp.innerText || "";
	}

	this.wrapOccurencesOf = function(subject, wrapperCreator) {
		var wrappedSubject = wrapStringWithWrapper(subject, wrapperCreator());
		replaceOccurencesOfStringWithStringInDocument(subject, wrappedSubject)
	};
	
	this.removeWrapperAround = function(tag) {
		var allElements = document.getElementsByTagName(tag);
		for (var i = 0; i < allElements.length; ++i) {
			var element = allElements[i];
			console.log(element)
			element = strip(element.outerHTML)
			console.log(element)
			console.log("")
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
			"baseURI": document.baseURI,
			"document": document.documentElement.innerHTML
		});
	},

	finalize: function(arguments) {
		clearHighlight();
		highlightWrapper(arguments["string"]);
	}
};

var ExtensionPreprocessingJS = new MyExtensionJavaScriptClass;
