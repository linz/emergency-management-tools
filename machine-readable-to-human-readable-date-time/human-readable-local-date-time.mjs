"use strict";

export function humanReadableLocalDateTime(dateTimeString, locales, timeZone) {
    let dateTime = new Date(dateTimeString);
    return dateTime.toLocaleString(locales, {
        dateStyle: "full",
        timeStyle: "medium",
        hourCycle: "h23",
        timeZone,
    });
}
