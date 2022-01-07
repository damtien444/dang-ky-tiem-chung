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


def days_diff_next_expect():
    return {
        '$project': {
            '_id': 0,
            'expected_day': {
                '$divide': [
                    {
                        '$subtract': [
                            '$next_expected_shot_date', '$$NOW'
                        ]
                    }, 1000 * 86400
                ]
            }
        }
    }


def cond_gen(message, variable, first=None, second=None, last=None, exception=None):
    empt = ""
    if first is not None and second is None and last is None and exception is None:
        return {
            '$cond': [
                {
                    '$lte': [
                        variable, first
                    ]
                }, message, empt
            ]
        }
    elif first is not None and second is not None and last is None and exception is None:
        return {
            '$cond': [
                {
                    '$and': [
                        {
                            '$gt': [
                                variable, first
                            ]
                        }, {
                            '$lte': [
                                variable, second
                            ]
                        }
                    ]
                }, message, empt
            ]
        }
    elif first is None and second is None and last is not None and exception is None:
        return {
            '$cond': [
                {
                    '$gt': [
                        variable, last
                    ]
                }, message, empt
            ]
        }
    elif exception is not None:
        return {
            '$cond': [
                {
                    '$lt': [
                        variable, exception
                    ]
                }, message, empt
            ]
        }


def concat_gen(list_range, variable):
    resutl = {'$project': {}}
    resutl['$project']['range'] = {}
    resutl['$project']['range']['$concat'] = []
    concat = resutl['$project']['range']['$concat']

    exception = 'no expect'
    concat.append(cond_gen(exception, variable, exception=-2000))
    for i in range(len(list_range) + 1):
        if i == 0:
            message = 'late more than ' + str(list_range[i]) + " days"
            concat.append(cond_gen(message, variable, first=-1000, second=list_range[i]))
        elif i == len(list_range):
            message = 'over more than ' + str(list_range[i - 1]) + 'days'
            concat.append(cond_gen(message, variable, last=list_range[i - 1]))
        else:
            message = 'in range ' + str(list_range[i - 1]) + '-' + str(list_range[i]) + ' days'
            concat.append(cond_gen(message, variable, first=list_range[i - 1], second=list_range[i]))

    return resutl


def by_province_distribute():
    return [
        {
            '$group': {
                '_id': '$address.province',
                'count': {
                    '$sum': 1
                }
            }
        },
        sort_order('count', -1)
    ]


def by_area_distribution(city, district=None, ward=None):
    match = match_area(city, district, ward)
    if district is not None and ward is not None:
        group = group_number('$address.ward')
    elif district is not None and ward is None:
        group = group_number('$address.ward')
    elif district is None and ward is None:
        group = group_number('$address.district')
    return [match, group, sort_order('count', -1)]


def by_next_shot_time_distribution():
    return [date_conversion_stage(), concat_gen([-7, 0, 7, 14, 28, 42, 72, 90], '$expected_day'),
            group_number('$range'), sort_order('count', -1)]


def by_next_shot_type_distribution():
    return [group_number('$next_expected_shot_type')]


def date_conversion_stage():
    return {
        '$project': {
            '_id': 0,
            'expected_day': {
                '$divide': [
                    {
                        '$subtract': [
                            '$next_expected_shot_date', '$$NOW'
                        ]
                    }, 1000 * 86400
                ]
            }
        }
    }


def group_number(key):
    return {
        '$group': {
            '_id': key,
            'count': {
                '$sum': 1
            }
        }
    }


def sort_order(field, order):
    return {
        '$sort': {
            field: order
        }
    }

# print(by_next_shot_time_distribution())

# print(concat_gen([-7, 0, 7, 14, 28, 42, 90], '$expected_day'))
