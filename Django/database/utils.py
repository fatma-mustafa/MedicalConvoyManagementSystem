from django.db import models

class Contraception_Method(models.Model):
    method = models.CharField(max_length=50, default='', unique=True)

    def __str__(self):
        return self.method