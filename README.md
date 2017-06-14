##### To build:
<code>npm install
</code>

##### To run the tests locally:
<code>./node_modules/.bin/wdio  ./config/wdio.conf.local.js
</code>

##### To run the tests on our selenium hub (with IE browser):
<code>./scripts/start_windows_node.sh
<br/>./node_modules/.bin/wdio ./config/wdio.conf.dev.ie.js
<br/>./scripts/stop_windows_node.sh
</code>