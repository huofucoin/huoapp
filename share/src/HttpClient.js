import axios from 'axios'

export const HttpInstance = axios.create({
    baseURL: 'http://39.105.162.206:8576/api',
    timeout: 60000,
});

HttpInstance.interceptors.response.use(function (response) {
    if (response.data.code === 0) {
        return response
    } else {
        throw new Error(response.data.msg)
    }
});