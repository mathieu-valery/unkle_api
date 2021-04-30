puts('Destroy previous instances...')
ContractOption.destroy_all
Subscription.destroy_all
User.destroy_all
Contract.destroy_all
Option.destroy_all
puts('Done !')


puts('Creating users...')
users = User.create!([
    {   first_name: 'Mathieu',
        last_name: 'Valéry',    
        date_of_birth: '1990-03-21',    
        email: 'mathieuvalery@gmail.com',    
        password: 'helloworld',
        admin: true },

    {   first_name: 'John',
        last_name: 'Doe',    
        date_of_birth: '1980-01-01',    
        email: 'johndoe@gmail.com',    
        password: 'helloworld',
        admin: false },

    {   first_name: 'Georges',
        last_name: 'Abitbol',    
        date_of_birth: '1980-01-01',    
        email: 'georgesabitbol@gmail.com',    
        password: 'helloworld',
        admin: false },
        
    {   first_name: 'Odile',
        last_name: 'Deray',    
        date_of_birth: '1980-01-01',    
        email: 'odilederay@gmail.com',    
        password: 'helloworld',
        admin: false },
        
        ])

puts('Done !')

puts('Creating contracts...')
contracts = Contract.create!([
    {
        number: '123456',
        status: 'active',
        date_start: '2021-01-01',
        date_end: '2022-01-01'
    }])

puts('Done !')


puts('Creating subscriptions...')
subscriptions = Subscription.create!([
    {
        user_id: User.first.id,
        contract_id: Contract.first.id
    }])

puts('Done !')


puts('Creating options...')
options = Option.create!([{name: 'all risk'}, {name: 'housebreaking'}, {name: 'fire'}, {name: 'natural disaster'}, {name: 'water damage'}])

puts('Done !')


puts('Creating contract options...')
contract_options = ContractOption.create!([
    {
        contract_id: Contract.first.id,
        option_id: Option.second.id
    },
    {
        contract_id: Contract.first.id,
        option_id: Option.third.id
    }])

puts('Done !')

puts('🌱 Seed planted ! 🌱')