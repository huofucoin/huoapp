import React from 'react'
import Logo from './logo@2x.png'
import Slogan from './slogan@2x.png'
import BG from './bg@2x.png'
import iOS from './ios@2x.png'
import Android from './android@2x.png'
import { useHistory } from 'react-router'

export default () => {
    let history = useHistory();
    return <div style={{
        height: '100vh', background: 'linear-gradient(136deg, #995CEF 0%, #602FDA 100%)',
        display: 'flex', flexDirection: 'column', alignItems: 'center', overflow: 'hidden'
    }}>
        <div style={{ width: '133px', height: '72px', paddingTop: '117px' }}>
            <img src={Logo} style={{ display: 'block', width: '100%', height: '100%' }} />
        </div>
        <div style={{ width: '246px', height: '23px', marginTop: '24px' }}>
            <img src={Slogan} style={{ display: 'block', width: '100%', height: '100%' }} />
        </div>
        <div style={{ width: '85%', maxWidth: '311px', marginTop: '40px' }}>
            <div style={{ position: 'relative', paddingBottom: '172%' }}>
                <div style={{ position: 'absolute', top: '0px', bottom: '0px', left: '0px', right: '0px' }}>
                    <img src={BG} style={{ display: 'block', width: '100%', height: '100%' }} />
                </div>
            </div>
        </div>
        <div style={{
            position: 'fixed', bottom: '0px', left: '0px', right: '0px', padding: '20px 14px', backgroundColor: 'white', boxShadow: '0px -5px 8px 0px rgba(175, 151, 236, 0.23)',
            display: 'flex'
        }}>
            <div onClick={() => {
                history.push('./ios')
            }} style={{
                flex: 1, height: '44px', background: 'linear-gradient(180deg, #995CEF 0%, #602FDA 100%)', borderRadius: '8px',
                boxShadow: '0px 20px 37px -19px rgba(96, 47, 218, 0.66), 0px 1px 3px 0px rgba(127, 142, 254, 0.48), 0px -1px 3px 0px rgba(96, 47, 218, 0.72)',
                display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '16px', color: 'white', cursor: 'pointer'
            }}>
                <img src={iOS} style={{ display: 'block', width: '30px', height: '30px', marginRight: '6px' }} />
                <span>iOS 下载</span>
            </div>
            <div style={{ width: '28px' }}></div>
            <a style={{ flex: 1, textDecoration: 'none' }} href='//invitation.huofu.ltd/huofu.apk'>
                <div style={{
                    height: '44px', background: 'linear-gradient(180deg, #995CEF 0%, #602FDA 100%)', borderRadius: '8px',
                    boxShadow: '0px 20px 37px -19px rgba(96, 47, 218, 0.66), 0px 1px 3px 0px rgba(127, 142, 254, 0.48), 0px -1px 3px 0px rgba(96, 47, 218, 0.72)',
                    display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '16px', color: 'white'
                }}>
                    <img src={Android} style={{ display: 'block', width: '30px', height: '30px', marginRight: '6px' }} />
                    <span>Android 下载</span>
                </div>
            </a>
        </div>
    </div>
}