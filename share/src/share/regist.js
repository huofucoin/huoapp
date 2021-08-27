import React, { useEffect, useState } from 'react';
import QueryString from 'query-string';
import { HttpInstance } from '../HttpClient';
import { useHistory, useLocation, useRouteMatch } from 'react-router';
import btnBg from './btn@2x.png'
import btnHLBg from './btn_hl@2x.png'
import registFont from './regist@2x.png'
import selectIcon from './selected@2x.png'
import unSelectIcon from './select@2x.png'

const styles = {
    inputContainer: {
        display: 'flex', height: '58px', borderRadius: '8px', backgroundColor: 'white', border: 'solid 1px white',
        marginTop: '24px', boxShadow: '0px 2px 8px -2px rgba(101, 69, 181, 0.21)'
    },
    input: { border: 'none', flex: 1, backgroundColor: 'transparent', width: '100%' }
}

export default () => {
    let location = useLocation()
    // let code = window.localStorage.getItem('code');
    // if (!code) {
    let query = QueryString.parse(location.search);
    let code = query.code ? query.code.toString() : '';
    //     window.localStorage.setItem('code', code ? code : '');
    // }
    let [isMobile, setMobile] = useState(true)
    let [parentcodes, setParentcodes] = useState(code ? code : '');
    let [username, setUsername] = useState('');
    let [vcode, setVcode] = useState('');
    let [password, setPassword] = useState('');
    let [confirm, setConfirm] = useState('');
    let [send, setSend] = useState(0);
    let [time, setTime] = useState(60);
    let [registing, setRegisting] = useState(false);
    let [select, setSelect] = useState(false)
    let history = useHistory()
    let match = useRouteMatch()

    let count = () => {
        if (send == 2) {
            if (time > 0) {
                setTimeout(() => {
                    setTime(time - 1)
                }, 1000);
            } else {
                setSend(0)
                setTime(60)
            }
        }
    };

    useEffect(count, [time, send])

    return <div style={{ padding: "16px 32px", backgroundColor: '#FAFAFA' }}>
        <div style={{ color: '#0D1333', fontSize: '26px', fontWeight: 600 }}>注册</div>
        <div style={{ padding: '32px 0px 0px', display: 'flex', justifyContent: 'space-between' }}>
            <div style={{ color: '#313333', fontSize: '17px', fontWeight: 600 }}>{isMobile ? '手机号' : '邮箱'}注册</div>
            <div style={{ color: '#602FDA', fontSize: '15px', fontWeight: 400 }} onClick={() => {
                setMobile(!isMobile)
                setUsername('')
                setVcode('')
            }}>{isMobile ? '邮箱' : '手机号'}注册</div>
        </div>
        <div style={styles.inputContainer}>
            {
                isMobile && <div style={{
                    color: '#313333', fontSize: '15px', padding: '0px 16px', margin: '16px 0px', borderRight: '#DDDDDD solid 1px',
                    display: 'flex', alignItems: 'center', justifyContent: 'center'
                }}>+86</div>
            }
            <div style={{ padding: '16px', flex: 1, display: 'flex' }}>
                <input style={styles.input} placeholder={isMobile ? '请输入手机号' : '请输入邮箱'} value={username} onChange={(e) => {
                    setUsername(e.target.value)
                }} />
            </div>
        </div>
        <div style={styles.inputContainer}>
            <div style={{ flex: 1, padding: '16px', overflow: 'hidden', display: 'flex' }}>
                <input style={styles.input} placeholder={isMobile ? '短信验证码' : '邮箱验证码'} value={vcode} onChange={(e) => {
                    setVcode(e.target.value)
                }} />
            </div>
            <div style={{
                color: '#602FDA', fontSize: '15px', padding: ' 0px 16px', margin: '16px 0px', minWidth: '80px', borderLeft: '#DDDDDD solid 1px',
                display: 'flex', alignItems: 'center', justifyContent: 'center'
            }} onClick={() => {
                if (send <= 0) {
                    setSend(1)
                    let requrest;
                    if (isMobile) {
                        requrest = HttpInstance.post('/getcode?' + QueryString.stringify({ mobile: username, type: 1 }))
                    } else {
                        requrest = HttpInstance.post('/emailgetcode?' + QueryString.stringify({ email: username, type: 1 }))
                    }
                    requrest.then(res => {
                        setSend(2)
                    }).catch(error => {
                        alert(error.message);
                        setSend(0)
                    })
                }
            }}>{send == 2 ? ('(' + time + 's)') : (send == 1 ? '发送中' : '发送验证码')}</div>
        </div>
        <div style={styles.inputContainer}>
            <div style={{ padding: '16px', flex: 1, display: 'flex' }}>
                <input type="password" style={styles.input} placeholder='请输入密码' value={password} onChange={(e) => {
                    setPassword(e.target.value)
                }} />
            </div>
        </div>
        <div style={styles.inputContainer}>
            <div style={{ padding: '16px', flex: 1, display: 'flex' }}>
                <input type="password" style={styles.input} placeholder='请再次输入密码' value={confirm} onChange={(e) => {
                    setConfirm(e.target.value)
                }} />
            </div>
        </div>
        <div style={styles.inputContainer}>
            <div style={{ padding: '16px', flex: 1, display: 'flex' }}>
                <input style={styles.input} placeholder='请输入邀请码' value={parentcodes} disabled={code} onChange={(e) => {
                    setParentcodes(e.target.value);
                }} />
            </div>
        </div>
        <div style={{ marginTop: '16px', color: '#5F6173', fontSize: '12px' }}>注：密码格式为8-15位，至少1位大写字母及1位数字</div>
        <div style={{ height: '108px', margin: '43px -25px 0px', position: 'relative' }}>
            <img src={select && username.length && password.length && confirm.length ? btnHLBg : btnBg} style={{ width: '100%', height: '100%', display: 'block' }} />
            <div onClick={() => {
                if (!select) {
                    alert('请阅读并同意火夫的《用户协议》')
                    return
                }
                if (!username.length) {
                    alert(isMobile ? '请输入手机号' : '请输入邮箱');
                    return
                }
                if (!new RegExp('^(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,15}$').test(password)) {
                    alert('密码格式为8-15位，至少1位大写字母及1位数字')
                    return
                }
                if (!password.length) {
                    alert('请输入密码');
                    return
                }
                if (password !== confirm) {
                    alert('两次输入密码不一致');
                    return
                }
                if (!registing) {
                    setRegisting(true)
                    let requrest;
                    if (isMobile) {
                        requrest = HttpInstance.post('/register?' + QueryString.stringify({ mobile: username, vcode, password, parentcodes }))
                    } else {
                        requrest = HttpInstance.post('/emailregister?' + QueryString.stringify({ emails: username, vcode, password, parentcodes }))
                    }
                    requrest.then(res => {
                        history.push({ pathname: match.path + '/download' })
                    }).catch(error => {
                        alert(error.message);
                        setRegisting(false)
                    })
                }
            }} style={{ position: 'absolute', top: '5px', bottom: '45px', left: '25px', right: '25px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <img src={registFont} style={{ width: '50px', height: '28px', display: 'block' }} />
            </div>
        </div>
        <div style={{ marginTop: '-35px', display: 'flex', alignItems: 'center', justifyContent: 'center', position: 'relative', zIndex: 1 }}>
            <div style={{ padding: '8px' }} onClick={() => {
                setSelect(!select)
            }}>
                <img style={{ width: '14px', height: '14px', display: 'block' }} src={select ? selectIcon : unSelectIcon} />
            </div>
            <div style={{ fontSize: '14px', color: '#ACACAC' }}>阅读并同意火夫的<span style={{ color: '#602FDA' }} onClick={() => {
                history.push({ pathname: match.path + '/agreement' })
            }}>《用户协议》</span></div>
        </div>
    </div>
}