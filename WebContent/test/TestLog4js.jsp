<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Log4js tests</title>
		<script src="<%=request.getContextPath()%>/js/log4js.js" type="text/javascript"></script>
		<script type="text/javascript">
		<!-- //
		   var ajaxLog = new Log4js.getLogger("ajaxTest");
		   ajaxLog.setLevel(Log4js.Level.ALL);
		   var ajaxAppender = new Log4js.AjaxAppender(ajaxLog, "./log4j.jsp");
		   ajaxAppender.setThreshold(5);
 		   ajaxLog.addAppender(ajaxAppender);

		   var windowEventLog = new Log4js.getLogger("windowEventTest");
		   windowEventLog.setLevel(Log4js.Level.ALL);
 		   windowEventLog.addAppender(new Log4js.WindowsEventAppender(windowEventLog));

		   var fileLog = new Log4js.Logger("fileTest");
		   fileLog.setLevel(Log4js.Level.ALL);
 		   fileLog.addAppender(new Log4js.FileAppender(fileLog, "C:\\log4js.log"));
		   
		   var consoleLog = new Log4js.Logger("consoleTest");
		   consoleLog.setLevel(Log4js.Level.ALL);
 		   consoleLog.addAppender(new Log4js.ConsoleAppender(consoleLog, true));
		   
		   var windowLog = new Log4js.getLogger("windowTest"); 
		   windowLog.setLevel(Log4js.Level.ALL);
 		   windowLog.addAppender(new Log4js.ConsoleAppender(windowLog)); //to windowLog to seperate windowLog window
		   
		   var alertLog = new Log4js.Logger("alertTest"); 
		   alertLog.setLevel(Log4js.Level.ALL);
 		   alertLog.addAppender(new Log4js.JSAlertAppender(alertLog));

 		   var operaLog = new Log4js.Logger("operaTest"); 
		   operaLog.setLevel(Log4js.Level.ALL);
		   var operaAppender = new Log4js.OperaJSConsoleAppender(operaLog);
 		   operaLog.addAppender(operaAppender);
 		   
		   var mozLog = new Log4js.getLogger("mozillaTest"); 
		   mozLog.setLevel(Log4js.Level.ALL);
		   var appender = new Log4js.MozJSConsoleAppender(mozLog);
		  //TODO appender.setLayout(new PatternLayout("%p-> %m"));
 		   mozLog.addAppender(appender);
 		   
 		// -->
 		</script>

		<script type="text/javascript">
		<!--
			function testAjax() {
				var logger = Log4js.getLogger("testlogger");
				logger.setLevel(Log4js.Level.ALL);
				//logger.addAppender(new Log4js.ConsoleAppender(logger));
				logger.addAppender(new Log4js.AjaxAppender(logger, "./log4j.jsp"));
		
				for(var i = 0; i <5 ; i++) {		
					logger.info('an info ' + i);
					logger.warn('a warning ' + i);
					logger.error('an error ' + i);
				}
			}
		//-->
		</script> 

	</head>

	<body>
		<h1>Log4js <script type="text/javascript">document.write(Log4js.version)</script> Tests</h1>
		<p><a href="http://log4js.berlios.de">Log4js</a> is a JavaScript 
			implementation of logging. Similar to the Java implementation Log4j.</p>
		<p style="color:red">Some loggers could cause a JavaScript exception on this page. This 
			could happen because the browser do not support all features.</p>
		<noscript>
			<blockquote>	
			<p>Log4js examples can be used only when JavaScript is enabled!</p>
			</blockquote>
		</noscript>
		
		
		<fieldset><legend>Window Console Logging</legend>
			<input type="text" id="windowMessage" value="add windowLog message" onchange="windowLog.trace(document.getElementById('windowMessage').value);"/>
			<input type="button" name="trace" value="Trace Message" onclick="windowLog.trace(document.getElementById('windowMessage').value);" />
			<br />
			<input type="button" name="trace" value="Trace" onclick="windowLog.trace('I was traced!');return false;" />
			<input type="button" name="debug" value="Debug" onclick="windowLog.debug('I was debuged!');return false;" />
			<input type="button" name="info" value="Info" onclick="windowLog.info('I was infoed!');return false;" />
			<input type="button" name="warn" value="Warn" onclick="windowLog.warn('I was warned!');return false;" />
			<input type="button" name="error" value="Error" onclick="windowLog.error('I was errored!');return false;" />
			<input type="button" name="fatal" value="Fatal" onclick="windowLog.fatal('I was fataled!');return false;" />
			&nbsp;&nbsp;
			<input type="button" name="test" value="Test window.error" onclick="badObject.badMethod;" />
		</fieldset>
		
		<fieldset><legend>Inline Console Logging (toggle on with ALT-D; on FireFox 2.0 use: SHIFT+ALT+D)</legend>
			<input type="checkbox" onchange="consoleLog.getAppender().toggle();" /> show/hide console.
			<input type="text" id="consoleMessage" value="add consoleLog message" onchange="consoleLog.trace(document.getElementById('consoleMessage').value);"/>
			<input type="button" name="trace" value="Trace Message" onclick="consoleLog.trace(document.getElementById('consoleMessage').value);" />
			<br />
			<input type="button" name="trace" value="Trace" onclick="consoleLog.trace('I was traced!');return false;" />
			<input type="button" name="debug" value="Debug" onclick="consoleLog.debug('I was debuged!');return false;" />
			<input type="button" name="info" value="Info" onclick="consoleLog.info('I was infoed!');return false;" />
			<input type="button" name="warn" value="Warn" onclick="consoleLog.warn('I was warned!');return false;" />
			<input type="button" name="error" value="Error" onclick="consoleLog.error('I was errored!');return false;" />
			<input type="button" name="fatal" value="Fatal" onclick="consoleLog.fatal('I was fataled!');return false;" />
		</fieldset>
		
		<fieldset><legend>Ajax Logging</legend>
			<input type="text" id="ajaxMessage" value="add ajaxLog message" onchange="ajaxLog.trace(document.getElementById('ajaxMessage').value);"/>
			<input type="button" name="trace" value="Trace Message" onclick="ajaxLog.trace(document.getElementById('ajaxMessage').value);" />
			<br />
			<input type="button" name="trace" value="Trace" onclick="ajaxLog.trace('I was traced!');return false;" />
			<input type="button" name="debug" value="Debug" onclick="ajaxLog.debug('I was debuged!');return false;" />
			<input type="button" name="info" value="Info" onclick="ajaxLog.info('I was infoed!');return false;" />
			<input type="button" name="warn" value="Warn" onclick="ajaxLog.warn('I was warned!');return false;" />
			<input type="button" name="error" value="Error" onclick="ajaxLog.error('I was errored!');return false;" />
			<input type="button" name="fatal" value="Fatal" onclick="ajaxLog.fatal('I was fataled!');return false;" />			
			<br />
			Sending a bigger number of logs: <input type="button" name="trace" value="ajaxTest" onclick="testAjax();return false;" />

		</fieldset>

		<fieldset><legend>Local File Logging (Internet Explorer only) (C:\log4js.log)</legend>
			<input type="text" id="fileMessage" value="add fileLog message" onchange="fileLog.trace(document.getElementById('fileMessage').value);"/>
			<input type="button" name="trace" value="Trace Message" onclick="fileLog.trace(document.getElementById('fileMessage').value);" />
			<br />
			<input type="button" name="trace" value="Trace" onclick="fileLog.trace('I was traced!');return false;" />
			<input type="button" name="debug" value="Debug" onclick="fileLog.debug('I was debuged!');return false;" />
			<input type="button" name="info" value="Info" onclick="fileLog.info('I was infoed!');return false;" />
			<input type="button" name="warn" value="Warn" onclick="fileLog.warn('I was warned!');return false;" />
			<input type="button" name="error" value="Error" onclick="fileLog.error('I was errored!');return false;" />
			<input type="button" name="fatal" value="Fatal" onclick="fileLog.fatal('I was fataled!');return false;" />
			&nbsp;&nbsp;
			<input type="button" name="clear" value="Clear Log" onclick="fileLog.clear();return false;" />
		</fieldset>
		
		<fieldset><legend>Window Event Logging (Internet Explorer only) (Control Panel &gt; Administrative Tools &gt; Event Viewer)</legend>
			<input type="text" id="winEventMessage" value="add windowEventLog message" onchange="windowEventLog.trace(document.getElementById('winEventMessage').value);"/>
			<input type="button" name="trace" value="Trace Message" onclick="windowEventLog.trace(document.getElementById('winEventMessage').value);" />
			<br />
			<input type="button" name="trace" value="Trace" onclick="windowEventLog.trace('I was traced!');return false;" />
			<input type="button" name="debug" value="Debug" onclick="windowEventLog.debug('I was debuged!');return false;" />
			<input type="button" name="info" value="Info" onclick="windowEventLog.info('I was infoed!');return false;" />
			<input type="button" name="warn" value="Warn" onclick="windowEventLog.warn('I was warned!');return false;" />
			<input type="button" name="error" value="Error" onclick="windowEventLog.error('I was errored!');return false;" />
			<input type="button" name="fatal" value="Fatal" onclick="windowEventLog.fatal('I was fataled!');return false;" />
		</fieldset>	
		
		<fieldset><legend>Alert Logging</legend>
			<input type="text" id="alertMessage" value="add alertLog message" onchange="alertLog.trace(document.getElementById('alertMessage').value);"/>
			<input type="button" name="trace" value="Trace Message" onclick="alertLog.trace(document.getElementById('alertMessage').value);" />
			<br />
			<input type="button" name="trace" value="Trace" onclick="alertLog.trace('I was traced!');return false;" />
			<input type="button" name="debug" value="Debug" onclick="alertLog.debug('I was debuged!');return false;" />
			<input type="button" name="info" value="Info" onclick="alertLog.info('I was infoed!');return false;" />
			<input type="button" name="warn" value="Warn" onclick="alertLog.warn('I was warned!');return false;" />
			<input type="button" name="error" value="Error" onclick="alertLog.error('I was errored!');return false;" />
			<input type="button" name="fatal" value="Fatal" onclick="alertLog.fatal('I was fataled!');return false;" />
		</fieldset>
		
		<fieldset><legend>Mozilla JavaScript Logging</legend>
			<input type="text" id="alertMessage2" value="add alertLog message" onchange="mozLog.trace(document.getElementById('alertMessage').value);"/>
			<input type="button" name="trace" value="Trace Message" onclick="mozLog.trace(document.getElementById('alertMessage').value);" />
			<br />
			<input type="button" name="trace" value="Trace" onclick="mozLog.trace('I was traced!');return false;" />
			<input type="button" name="debug" value="Debug" onclick="mozLog.debug('I was debuged!');return false;" />
			<input type="button" name="info" value="Info" onclick="mozLog.info('I was infoed!');return false;" />
			<input type="button" name="warn" value="Warn" onclick="mozLog.warn('I was warned!');return false;" />
			<input type="button" name="error" value="Error" onclick="mozLog.error('I was errored!');return false;" />
			<input type="button" name="fatal" value="Fatal" onclick="mozLog.fatal('I was fataled!');return false;" />
		</fieldset>
		
		<fieldset><legend>Opera JavaScript Logging</legend>
			<input type="text" id="alertMessage3" value="add alertLog message" onchange="operaLog.trace(document.getElementById('alertMessage').value);"/>
			<input type="button" name="trace" value="Trace Message" onclick="operaLog.trace(document.getElementById('alertMessage').value);" />
			<br />
			<input type="button" name="trace" value="Trace" onclick="operaLog.trace('I was traced!');return false;" />
			<input type="button" name="debug" value="Debug" onclick="operaLog.debug('I was debuged!');return false;" />
			<input type="button" name="info" value="Info" onclick="operaLog.info('I was infoed!');return false;" />
			<input type="button" name="warn" value="Warn" onclick="operaLog.warn('I was warned!');return false;" />
			<input type="button" name="error" value="Error" onclick="operaLog.error('I was errored!');return false;" />
			<input type="button" name="fatal" value="Fatal" onclick="operaLog.fatal('I was fataled!');return false;" />
		</fieldset>
		
	</body>
</html>