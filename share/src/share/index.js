import React from 'react'
import { Route, Switch, useRouteMatch } from 'react-router'
import Regist from './regist'
import Download from './download'
import iOS from './ios'
import Agreement from './agreement'

export default () => {
    let match = useRouteMatch()
    return <Switch>
        <Route path={match.path + '/agreement'} component={Agreement} />
        <Route path={match.path + '/ios'} component={iOS} />
        <Route path={match.path + '/download'} component={Download} />
        <Route path={match.path} component={Regist} />
    </Switch>
}