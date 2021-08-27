import { HashRouter as Router, Switch, Route, Redirect } from 'react-router-dom';
import Share from './share'

function App() {
  return (
    <Router>
      <Switch>
        <Route path='/share' component={Share} />
        <Route path='/' render={() => {
          return <Redirect to='/share' />
        }} />
      </Switch>
    </Router>
  );
}

export default App;
