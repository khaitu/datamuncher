FORMAT: 1A

# Data Muncher

Quick and dirty data consumer/supplier.

## Collections Retrieval [/]

### Retrieve [GET]

Returns all the available collections stored in the database

+ Response 200 (application/json)

    + Body

            {
                collections: [ "cabbage", "potato", "carrot" ]
            }

## Collection Retrieval [/spit/{collection}]

+ Parameters

    + collection (required, string, `cabbage`) ... Name of the collection

### Retrieve [GET]

Returns datapoints for the given collection. Limited to 4000 datapoints.

If there is additional metadata, this will also be returned.

Root JSON property is the name of the collection.

+ Response 200 (application/json)

    + Body

            {
                "cabbage": [
                    {
                        "date": "2015-01-01T00:00:00Z",
                        "value": 2.53
                    },
                    {
                        "date": "2015-01-01T00:01:00Z",
                        "value": 2.20,
                        "meta":
                        {
                            "client": 2401
                        }
                    }
                ]
            }

## Datapoint Insertion [/chew/{collection}]

+ Parameters

    + collection (required, string, `cabbage`) ... Name of the collection

### Post [POST]

Accepts one datapoint.

+ Request (application/json)

    | Field              | Type     | Required   | Description                                                 |
    |--------------------|----------|------------|-------------------------------------------------------------|
    | `value`            | Number   | Yes        | Value of the datapoint                                      |
    | `date`             | String   | No         | Date for which the value applies. Defaults to current time. |
    | `meta`             | String   | No         | Optional metadata for the datapoint.                        |

    + Body

            {
                "value": 2.53,
                "date": "2015-01-01T00:00:00Z",
                "meta":
                {
                    "weight": 24
                }
            }

+ Response 200 (application/json)

    Root JSON property is the name of the collection.

    + Body

            {
                "cabbage": {
                    "date": "2015-01-01T00:00:00Z",
                    "value": 2.53,
                    "meta":
                    {
                        "weight": 24
                    }
                }
            }

## Collection Removal [/vom/{collection}]

+ Parameters

    + collection (required, string, `cabbage`) ... Name of the collection

### Remove [DELETE]

Purges all datapoints for a given collection.

+ Response 204
