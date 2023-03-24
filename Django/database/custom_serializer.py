from rest_framework import serializers

class custom_serializer(serializers.ModelSerializer):
    def create(self, validated_data):
        print(validated_data)
        return super().create(validated_data)