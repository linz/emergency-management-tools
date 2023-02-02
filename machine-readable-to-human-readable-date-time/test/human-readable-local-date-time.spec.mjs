"use strict";

import { humanReadableLocalDateTime } from "../human-readable-local-date-time.mjs";

function assertEqual(expected, actual) {
    if (expected !== actual) {
        throw new Error(expected + " !== " + actual);
    }
}

describe("humanReadableLocalDateTime", function () {
    it("should return datetime in time zone formatted according to locale", function () {
        assertEqual(
            "Saturday, 1 January 2000 at 13:00:00",
            humanReadableLocalDateTime(
                "2000-01-01T00:00:00Z",
                "en-NZ",
                "Pacific/Auckland"
            )
        );
    });
    it("should support non-New Zealand time zones and locales", function () {
        assertEqual(
            "lørdag 1. januar 2000 kl. 01:00:00",
            humanReadableLocalDateTime(
                "2000-01-01T00:00:00Z",
                "nb-NO",
                "Europe/Oslo"
            )
        );
    });
    it("should use defaults for locale and time zone (must run in a Node.js process with `TZ=UTC` and `LC_MESSAGES=C`)", function () {
        if (
            typeof process === "undefined" ||
            process.env.TZ !== "UTC" ||
            process.env.LC_MESSAGES !== "C"
        ) {
            this.skip();
        }
        assertEqual(
            "Saturday, January 1, 2000 at 00:00:00",
            humanReadableLocalDateTime("2000-01-01T00:00:00Z")
        );
    });
    it("should return 'Invalid Date' for invalid date", function () {
        assertEqual(
            "Invalid Date",
            humanReadableLocalDateTime("not a date/time")
        );
    });
});
