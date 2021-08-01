from django.http.response import JsonResponse
from rest_framework.permissions import IsAuthenticated 
from rest_framework.authentication import TokenAuthentication
from .models import SocietyMaster
from .serializers import SocietySerializer
from rest_framework.views import APIView


# Create your views here.

class getAllSociety(APIView):

    authentication_classes=[TokenAuthentication]
    permission_classes=[IsAuthenticated]
    def get(self,request,soc):
        queryset=SocietyMaster.objects.filter(name__iexact=soc)
        soc=SocietySerializer(queryset,context={'request':request},many=True)
        return JsonResponse(soc.data,safe=False)


