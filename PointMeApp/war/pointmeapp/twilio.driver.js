function LoginSendText(sendObject) {

   var sendObject = {}
   sendObject['from'] = "5123841298";
   sendObject['body'] = " Testing Twilio Text Test";
   sendObject['to'] = "2102159942"
   $.ajax({
   	type:"GET",
   	url: "https://AC737f025b7c7506fb64d75e4737ad8143:aaf1131572f1f8b22f00fea818ba28d7@api.twilio.com/2010-04-01/Accounts",	
   	success: function() {
   		$.ajax({
   			type:"POST",
   			url: "https://api.twilio.com/2010-04-01/Accounts/AC737f025b7c7506fb64d75e4737ad8143/SMS/Messages.json",
   			data: sendObject,
   			success: function() {
   				alert("success");
   			},
   		});
   	},
   });
}

