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
        # gym_cdが一意制約を持つことをテストします。
        self.setup()
        field = self.gym._meta.get_field("gym_cd")
        self.assertTrue(field.unique)

    def test_gym_cd_field_type(self):
        self.setup()
        field = self.gym._meta.get_field("gym_cd")
        self.assertEqual(field.get_internal_type(), "IntegerField")

    def test_gym_nm_is_unique(self):
        # gym_nmが一意制約を持つことをテストします。
        self.setup()
        field = self.gym._meta.get_field("gym_nm")
        self.assertTrue(field.unique)

    def test_gym_nm_does_not_allow_null(self):
        # nullを許容していないフィールドのテスト
        gym = Gym(
            gym_cd=2,
            gym_nm=None,  # null値を指定します
            gym_hp_link="http://example.com",
            gym_addr="Example Address",
            gym_phone_reserve_link="http://example.com/phone",
            gym_net_reserve_link="http://example.com/net",
        )
        with self.assertRaises(Exception):
            gym.full_clean()  # cleanメソッドを呼び出し、例外が発生することを確認します

    def test_gym_nm_field_type(self):
        self.setup()
        field = self.gym._meta.get_field("gym_nm")
        self.assertEqual(field.get_internal_type(), "CharField")

    def test_gym_nm_has_correct_max_length(self):
        gym = Gym(
            gym_cd=3,
            gym_nm="A" * 101,  # 101文字の文字列を指定します
            gym_hp_link="http://example.com",
            gym_addr="Example Address",
            gym_phone_reserve_link="http://example.com/phone",
            gym_net_reserve_link="http://example.com/net",
        )
        with self.assertRaises(Exception):
            gym.full_clean()  # cleanメソッドを呼び出し、例外が発生することを確認します

        gym_nm_field = Gym._meta.get_field("gym_nm")
        self.assertEqual(gym_nm_field.max_length, 100)

    def test_gym_hp_link_field_type(self):
        self.setup()
        field = self.gym._meta.get_field("gym_hp_link")
        self.assertEqual(field.get_internal_type(), "CharField")

    def test_gym_hp_link_has_correct_max_length(self):
        gym = Gym(
            gym_cd=4,
            gym_nm="Example Gym",
            gym_hp_link="A" * 256,
            gym_addr="Example Address",
            gym_phone_reserve_link="http://example.com/phone",
            gym_net_reserve_link="http://example.com/net",
        )
        with self.assertRaises(Exception):
            gym.full_clean()  # cleanメソッドを呼び出し、例外が発生することを確認します

        gym_hp_link_field = Gym._meta.get_field("gym_hp_link")
        self.assertEqual(gym_hp_link_field.max_length, 255)

    def test_gym_addr_does_not_allow_null(self):
        # nullを許容していないフィールドのテスト
        gym = Gym(
            gym_cd=2,
            gym_nm="Example Gym",
            gym_hp_link="http://example.com",
            gym_addr=None,
            gym_phone_reserve_link="http://example.com/phone",
            gym_net_reserve_link="http://example.com/net",
        )
        with self.assertRaises(Exception):
            gym.full_clean()  # cleanメソッドを呼び出し、例外が発生することを確認します

    def test_gym_addr_field_type(self):
        self.setup()
        field = self.gym._meta.get_field("gym_addr")
        self.assertEqual(field.get_internal_type(), "CharField")

    def test_gym_addr_has_correct_max_length(self):
        gym = Gym(
            gym_cd=3,
            gym_nm="A" * 101,  # 101文字の文字列を指定します
            gym_hp_link="http://example.com",
            gym_addr="Example Address",
            gym_phone_reserve_link="http://example.com/phone",
            gym_net_reserve_link="http://example.com/net",
        )
        with self.assertRaises(Exception):
            gym.full_clean()  # cleanメソッドを呼び出し、例外が発生することを確認します

        gym_addr_field = Gym._meta.get_field("gym_addr")
        self.assertEqual(gym_addr_field.max_length, 100)
