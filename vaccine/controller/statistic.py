
from vaccine import app, request, Message, mail, render_template
from vaccine.controller.app_test import admin_required
from vaccine.controller.service import db
from vaccine.model.agregation_pipeline import match_area, by_group_distribution, sort_order, by_age_distribution, \
    by_sex_distribution, by_next_shot_time_distribution, \
    by_next_shot_type_distribution, by_province_distribute, by_area_distribution

sign = db['vaccination_sign']


@app.route('/campaign-statistic', methods=['POST'])
@admin_required
def vaccine_statistic_gathering(user):
    try:

        data = request.get_json()

        address = data['address']

        city = address['province']
        district = None
        ward = None
        try:
            if address['district'] is not None:
                district = address['district']
            if address['ward'] is not None:
                ward = address['ward']
        except Exception as ignore:
            pass

        match_stage = match_area(city, district, ward)

        group_by_priority = sign.aggregate([
            match_stage,
            by_group_distribution(),
            sort_order('_id', -1)
        ])

        pipeline = [match_stage]
        pipeline.extend(by_age_distribution())
        group_by_age = sign.aggregate(pipeline)

        pipeline = [match_stage, by_sex_distribution()]
        group_by_sex = sign.aggregate(pipeline)

        pipeline = [match_stage]
        pipeline.extend(by_next_shot_time_distribution())
        group_by_next_shot_time = sign.aggregate(pipeline)

        pipeline = [match_stage]
        pipeline.extend(by_next_shot_type_distribution())
        group_by_next_shot_type = sign.aggregate(pipeline)

        pipeline = by_province_distribute()
        group_by_province = sign.aggregate(pipeline)

        pipeline = by_area_distribution(city, district, ward)
        group_by_area = sign.aggregate(pipeline)

        by_priority = []
        for thing in group_by_priority:
            by_priority.append(thing)

        by_age = []
        for thing in group_by_age:
            by_age.append(thing)

        by_sex = []
        for thing in group_by_sex:
            by_sex.append(thing)

        by_next_shot_time = []
        for thing in group_by_next_shot_time:
            by_next_shot_time.append(thing)


        by_next_shot_type = []
        for thing in group_by_next_shot_type:
            by_next_shot_type.append(thing)

        by_province = []
        for thing in group_by_province:
            by_province.append(thing)

        by_area = []
        for thing in group_by_area:
            by_area.append(thing)

        return {'result': 'success', 'by_priority': by_priority, 'by_age': by_age,
                'by_sex': by_sex, 'by_next_shot_time': by_next_shot_time, 'by_next_shot_type': by_next_shot_type,
                'by_province': by_province, 'by_area': by_area}, 200

    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'not able to gather statistic information'}, 400


