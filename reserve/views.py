from django.shortcuts import render

from .models import Gym


# Create your views here.
def index(request):
    gyms = Gym.objects.all()
    return render(
        request,
        "reserve/index.html",
        {"gyms": gyms},
    )
