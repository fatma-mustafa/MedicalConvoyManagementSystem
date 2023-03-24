from django.db import models
import datetime

class Code(models.UUIDField):
    def __init__(self, *args, **kwargs):
        super().__init__(max_length=10, unique=True, editable=False)

    def generate_id(self, model_instance):
        prefix = datetime.datetime.now().strftime("%a")[:3].upper()
        model_class = model_instance.__class__
        print(model_class)
        last_id = model_class.objects.order_by('id').last()
        
        return last_id + 1
    
    def pre_save(self, model_instance, add):
        if add:
            value = self.generate_id(model_instance)
            setattr(model_instance, self.attname, value)
            return value
        else:
            return super().pre_save(model_instance, add)