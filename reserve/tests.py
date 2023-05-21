from django.test import TestCase

from .models import Gym


class GymModelTest(TestCase):
    def setup(self):
        # テストに必要な初期データをセットアップする場合は、setUpメソッドを使用します。
        self.gym = Gym.objects.create(
            gym_cd=1,
            gym_nm="Example Gym",
            gym_hp_link="http://example.com",
            gym_addr="Example Address",
            gym_phone_reserve_link="http://example.com/phone",
            gym_net_reserve_link="http://example.com/net",
        )
