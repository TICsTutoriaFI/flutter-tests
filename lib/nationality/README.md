# Nationality

Not all code lives in the front-end, sometimes we need to pass information for this purpose it's common to use APIs.

## Instructions

Inside the `main.dart` file you will find a class called `Nationality` and a method called `getNationality()`.

Using [Dio](https://pub.dev/packages/dio) make a petition to the [Nationalize.io API](https://nationalize.io/documentation) taking only the `name` attribute of the given class, and when called the method must return:

`NAME is from COUNTRY_ID with PERCENTAGE certainty`

Where `COUNTRY_ID` is the country id with the highest probability, `PERCENTAGE` is the number from the `probability` field converted to a percentage using only the four first decimals.

So for the name "Johnson" we expect the output:

`Johnson is from CM with 7.38% certainty`

If no information is returned, the string then must be:

`NAME not available`

## NOTE

- The Nationalize API has a rate limit of 100 petitions/day
- Do not get worried about errors out of your control (connection errors, server not available, etc.)
