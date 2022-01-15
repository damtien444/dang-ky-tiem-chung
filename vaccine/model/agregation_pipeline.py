from datetime import datetime, timezone


def match_area(city, district=None, ward=None):
    match = {'address.province': city}

    if district is not None:
        match['address.district'] = district

    if ward is not None:
        match['address.ward'] = ward

    return {'$match': match}


def by_group_distribution():
    return group_number('$priority_group')


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

    group_by_range = group_number('$range')

    pipeline = [
        age_project,
        range_concat,
        group_by_range
    ]

    return pipeline


def by_sex_distribution():
    return group_number('$sex')


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
            message = 'over more than ' + str(list_range[i - 1]) + ' days'
            concat.append(cond_gen(message, variable, last=list_range[i - 1]))
        else:
            message = 'in range ' + str(list_range[i - 1]) + '-' + str(list_range[i]) + ' days'
            concat.append(cond_gen(message, variable, first=list_range[i - 1], second=list_range[i]))

    return resutl


def by_province_distribute():
    return [
        group_number('$address.province'),
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
            group_number('$range')]


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


def create_list_people_in_campaign(time_range_start, time_range_finish, shot_type, city, district=None, ward=None,
                                   min_age=0, max_age=150, priority_type=None, illness_history=False):



    pipeline = [match_area(city, district, ward)]

    filter_illness =  {
            '$match': {
                'illness_history': illness_history
            }
        }

    calculate_age = {
        '$project': {
            'priority_group': 1,
            'next_expected_shot_date': 1,
            'next_expected_shot_type': 1,
            'sex':1,
            "illness_history":1,
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

    filter_age_range = {
        '$match': {
            'age': {
                '$gt': min_age,
                '$lt': max_age
            }
        }
    }

    filter_shot_type = {
        '$match': {
            '$or': [
                {
                    'next_expected_shot_type': {
                        '$eq': 'NO_NEXT'
                    }
                }, {
                    'next_expected_shot_type': {
                        '$eq': shot_type
                    }
                }
            ]
        }
    }

    # datetime(2015, 6, 17, 10, 3, 46, tzinfo=timezone.utc)

    default_date = datetime(2000, 1, 1, 1, 0, 0, tzinfo=timezone.utc)
    filter_shot_expect_date = {
        '$match': {
            '$or': [
                {
                    'next_expected_shot_date': {
                        '$gte': time_range_start,
                        '$lte': time_range_finish
                    }
                }, {
                    'next_expected_shot_date': {
                        '$lt': default_date
                    }
                }
            ]
        }
    }
    if illness_history is not None:
        pipeline.append(filter_illness)

    pipeline.append(calculate_age)
    pipeline.append(filter_age_range)
    if priority_type is not None:
        pipeline.append(filter_priority_group(priority_type))

    pipeline.append(filter_shot_type)
    pipeline.append(filter_shot_expect_date)

    return pipeline


def filter_priority_group(priority):
    return {
        '$match': {
            'priority_group': priority
        }
    }

# print(create_list_people_in_campaign("Thành phố Đà Nẵng"))
# print(by_next_shot_time_distribution())

# print(concat_gen([-7, 0, 7, 14, 28, 42, 90], '$expected_day'))
