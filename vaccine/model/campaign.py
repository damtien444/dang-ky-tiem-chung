class Campaign:

    def __init__(self, name, list_of_people, date_start, date_end, vaccine_type, place, type_of_people, status):
        self.name = name
        self.list_of_people = list_of_people
        self.date_start = date_start
        self.date_end = date_end
        self.vaccine_type = vaccine_type
        self.place = place
        self.type_of_people = type_of_people
        self.status = status

    def to_json(self):
        return {
            'name': self.name,
            'list_of_people': self.list_of_people,
            'date_start': self.date_start,
            'date_end': self.date_end,
            'date_place': self.place,
            'type_of_people': self.type_of_people,
            'status': self.status
        }