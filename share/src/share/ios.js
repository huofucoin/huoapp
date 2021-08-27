import React from 'react'
import iOSBG from './ios_bg.png'

export default () => {
    return <div style={{ position: 'relative' }}>
        <div style={{ position: 'relative', paddingBottom: '390%' }}>
            <div style={{ position: 'absolute', top: '0px', bottom: '0px', left: '0px', right: '0px' }}>
                <img src={iOSBG} style={{ display: 'block', width: '100%', height: '100%' }} />
            </div>
        </div>
        <div style={{ position: 'absolute', left: '0px', top: '0px', right: '0px', bottom: '0px', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
            <div style={{ position: 'relative', paddingBottom: '72.5%' }}>
            </div>
            <div style={{ width: '70.7%' }}>
                <a href="https://apps.apple.com/cn/app/testflight/id899247664">
                    <div style={{ position: 'relative', paddingBottom: '15.1%' }}>
                    </div>
                </a>
            </div>
            <div style={{ position: 'relative', paddingBottom: '114.7%' }}>
            </div>
            <div style={{ width: '70.7%' }}>
                <a href="https://testflight.apple.com/join/oHjzmyzb">
                    <div style={{ position: 'relative', paddingBottom: '15.1%' }}>
                    </div>
                </a>
            </div>
        </div>
    </div>
}