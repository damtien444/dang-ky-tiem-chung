def match_area(city, district=None, ward=None):
    match = {'address.province': city}

    if district is not None:
        match['address.district'] = district

    if ward is not None:
        match['address.ward'] = ward

    return {'$match': match}


def by_group_distribution():
    return {
        '$group': {
            '_id': '$priority_group',
            'number': {
                '$sum': 1
            }
        }
    }


def by_age_distribution():
    age_project = {
        '$project': {
            '_id': 0,
            'age': {
                '$divide': [
                    {
                        '$subtract': [
                            '$$NOW', '$birth_day'
                        ]
                    }, 1000 * 86400 * 365
                ]
            }
        }
    }
    range_concat = {
        '$project': {
            'range': {
                '$concat': [
                    {
                        '$cond': [
                            {
                                '$lte': [
                                    '$age', 0
                                ]
                            }, 'Unknown', ''
                        ]
                    }, {
                        '$cond': [
                            {
                                '$and': [
                                    {
                                        '$gt': [
                                            '$age', 0
                                        ]
                                    }, {
                                        '$lt': [
                                            '$age', 6
                                        ]
                                    }
                                ]
                            }, 'Under 6', ''
                        ]
                    }, {
                        '$cond': [
                            {
                                '$and': [
                                    {
                                        '$gte': [
                                            '$age', 6
                                        ]
                                    }, {
                                        '$lt': [
                                            '$age', 12
                                        ]
                                    }
                                ]
                            }, '6 - 12', ''
                        ]
                    }, {
                        '$cond': [
                            {
                                '$and': [
                                    {
                                        '$gte': [
                                            '$age', 12
                                        ]
                                    }, {
                                        '$lt': [
                                            '$age', 18
                                        ]
                                    }
                                ]
                            }, '12 - 18', ''
                        ]
                    }, {
                        '$cond': [
                            {
                                '$and': [
                                    {
                                        '$gte': [
                                            '$age', 18
                                        ]
                                    }, {
                                        '$lt': [
                                            '$age', 65
                                        ]
                                    }
                                ]
                            }, '18 - 65', ''
                        ]
                    }, {
                        '$cond': [
                            {
                                '$gte': [
                                    '$age', 65
                                ]
                            }, 'Over 65', ''
                        ]
                    }
                ]
            }
        }
    }

    group_by_range = {
        '$group': {
            '_id': '$range',
            'count': {
                '$sum': 1
            }
        }
    }

    pipeline = [
        age_project,
        range_concat,
        group_by_range,
        sort_order('count', -1)
    ]

    return pipeline


def by_sex_distribution():
    group_command = {
        '$group': {
            '_id': '$sex',
            'count': {
                '$sum': 1
            }
        }
    }
    return group_command


def sort_order(field, order):
    return {
        '$sort': {
            field: order
        }
    }
