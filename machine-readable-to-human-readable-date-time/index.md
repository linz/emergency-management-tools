---
layout: default
---

# Convert date/time from machine-readable to human-readable

<form id="human-readable-date-time-form">
<label for="machine-readable-date-time" style="display: inline;">Machine readable date/time</label>
<input id="machine-readable-date-time" name="machine-readable-date-time" type="text" required style="width: auto;"><br/>
in detected language code <em id="language"></em> and time zone <em id="time-zone"></em>:<br/>
<strong><time id="human-readable-date-time"></time></strong> <button id="copy-human-readable-date-time">Copy</button>
</form>

<script type="module">
import {humanReadableLocalDateTime} from "{{ '/machine-readable-to-human-readable-date-time/human-readable-local-date-time.mjs' | relative_url }}";

const formElement = document.getElementById("human-readable-date-time-form");
const inputElement = document.getElementById("machine-readable-date-time");
const languageElement = document.getElementById("language");
const timeZoneElement = document.getElementById("time-zone");
const outputElement = document.getElementById("human-readable-date-time");
const copyButtonElement = document.getElementById("copy-human-readable-date-time");

const nowAsISOString = new Date().toISOString();

inputElement.value = nowAsISOString;
languageElement.innerText = navigator.language;
timeZoneElement.innerText = Intl.DateTimeFormat().resolvedOptions().timeZone;
outputElement.setAttribute("datetime", nowAsISOString);
outputElement.innerText = humanReadableLocalDateTime(nowAsISOString);

inputElement.addEventListener("input", (event) => {
  event.preventDefault();
  new FormData(formElement);
});

inputElement.addEventListener("focus", (event) => {
  inputElement.value = "";
});

formElement.addEventListener("formdata", (event) => {
  outputElement.innerText = humanReadableLocalDateTime(event.formData.get("machine-readable-date-time"));
});

copyButtonElement.addEventListener("click", (event) => {
  navigator.clipboard.writeText(outputElement.innerText);
});

formElement.addEventListener("submit", (event) => {
  /* Avoid changing the page URL */
  event.preventDefault();
});
</script>

---

## Features

-  Localised - the output is in the main language of your browser. Defaults to
   US English if no language is configured.
-  Time zone conversion to match your local configuration. Defaults to UTC if no
   language is configured, or if
   [Firefox's protection against fingerprinting](https://mzl.la/3dlIvK2) is
   enabled:
   > Your timezone is reported to be UTC
-  Updates whenever you change the input field.
-  Clears the input field when you click it, for faster pasting.
-  Forces 24-hour clock.

## Technical stuff

This is a more user-friendly approach than
`date --date=INPUT +'%A, %-d %B %+4Y at %-I:%M:%S %P %Z'`, which gives a similar
result, but is not localised.

If you're interested in how this works, the
[code]({{ '/machine-readable-to-human-readable-date-time/human-readable-local-date-time.mjs' | relative_url }})
and
[tests](https://github.com/linz/emergency-management-tools/blob/master/machine-readable-to-human-readable-date-time/test/human-readable-local-date-time.spec.mjs)
are both available.

Basically, the input must be a valid
[`Date` constructor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/Date)
argument, and will be converted to the locale and time zone of your browser.
