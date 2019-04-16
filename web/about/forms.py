from django import forms


class ChatSignupForm(forms.Form):
    email = forms.EmailField(max_length=200,
                             label="Email",
                             required=True)
