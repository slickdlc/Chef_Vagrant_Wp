# InSpec test for recipe database::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/
describe 'Update OS' do
  it { is_expected.to run_execute('update') }
end

describe 'Open port 3306 and reload firewall' do
  it { is_expected.to run_execute('firewall-cmd --zone=public --add-port=3306/tcp --permanent') }
  it { is_expected.to run_execute('firewall-cmd --reload') }
end

it 'installs mysql-server' do
  expect(chef_run).to install_package('mysql-server')
end

it 'enables and starts the mysqld service' do
  expect(chef_run).to enable_service('mysqld')
  expect(chef_run).to start_service('mysqld')
end

describe 'creates the wordpress database' do
  it { is_expected.to run_execute('create_mysql_database') }
end

describe 'creates the mysql user and grants privileges' do
  it { is_expected.to run_execute('create_mysql_user') }
end