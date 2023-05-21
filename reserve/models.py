from django.db import models


class Gym(models.Model):
    gym_cd = models.IntegerField(primary_key=True, unique=True)
    gym_nm = models.CharField(unique=True, null=False, max_length=100)
    gym_hp_link = models.CharField(unique=True, max_length=255)
    gym_addr = models.CharField(null=False, max_length=100)
    gym_phone_reserve_link = models.CharField(max_length=255)
    gym_net_reserve_link = models.CharField(max_length=255)
