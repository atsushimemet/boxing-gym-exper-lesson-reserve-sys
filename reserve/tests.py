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

    def test_gym_cd_is_primary_key(self):
        # gym_cdが主キーであることをテストします。
        self.setup()
        self.assertEqual(self.gym._meta.pk.name, "gym_cd")

    def test_gym_cd_is_unique(self):
        # gym_nmが一意制約を持つことをテストします。
        self.setup()
        field = self.gym._meta.get_field("gym_cd")
        self.assertTrue(field.unique)

    def test_gym_cd_field_type(self):
        self.setup()
        field = self.gym._meta.get_field("gym_cd")
        self.assertEqual(field.get_internal_type(), "IntegerField")
