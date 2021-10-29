import from 'vue'
import { ValidationObserver, ValidationProvider, extend }
import { required, email } from 'vee-validate/dist/rules'

Vue.component('ValidationObserver', ValidationObserver)
Vue.component('ValidationProvider', ValidationProvider)

extend('required', {
  ...required,
  message: "{_field_}は必須項目です"
});

extend('email', {
  ...email,
  message: "{_field_}の形式でご入力ください"
});
