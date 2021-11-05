import Vue from 'vue'
import { ValidationObserver, ValidationProvider, extend } from 'vee-validate'
import { required, email, max, min } from 'vee-validate/dist/rules'
import axios from './axios'

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

extend('max', {
  ...max,
  message: "{_field_}は{length}文字以下で入力してください"
});

extend('min', {
  ...min,
  message: "{_field_}は{length}文字以上で入力してください"
});

extend('password_confirmed', {
  params: ['target'],
  validate(value, { target }) {
    return value === target;
  },
  message: "パスワードと一致しません"
});

const isUnique = (value) => {
  return axios.post('/validate/email', { email: value }).then((response) => {
    return {
      valid: response.data === false
    };
  });
};

extend('unique', {
  validate: isUnique,
  message: "このメールアドレスは登録済みです"
});
