require 'rspec/its'
require_relative '/home/diana/LR3/models/student'

RSpec.describe Student do
    let(:valid_phone) { '+7 (800)-555-35-53' }
    let(:invalid_phone) { '12345' }
    let(:valid_name) { 'Олег' }
    let(:invalid_name) { 'Oleg' }
    let(:valid_account) { '@olegggg' }
    let(:invalid_account) { 'username' }
    let(:valid_email) { 'olesha1996@gmail.com' }
    let(:invalid_email) { 'example@com' }

    describe '.valid_phone?' do
        it 'returns true for a valid phone number' do
            expect(Student.valid_phone?(valid_phone)).to be true
        end

        it 'returns false for an invalid phone number' do
            expect(Student.valid_phone?(invalid_phone)).to be false
        end
    end

    describe '.valid_name?' do
        it 'returns true for a valid name' do
            expect(Student.valid_name?(valid_name)).to be true
        end

        it 'returns false for an invalid name' do
            expect(Student.valid_name?(invalid_name)).to be false
        end
    end

    describe '.valid_account?' do
        it 'returns true for a valid account' do
            expect(Student.valid_acc?(valid_account)).to be true
        end

        it 'returns false for an invalid account' do
            expect(Student.valid_acc?(invalid_account)).to be false
        end
    end

    describe '.valid_email?' do
        it 'returns true for a valid email' do
            expect(Student.valid_email?(valid_email)).to be true
        end

        it 'returns false for an invalid email' do
            expect(Student.valid_email?(invalid_email)).to be false
        end
    end

    describe '#initialize' do
        it 'sets the instance variables correctly' do
            student = Student.new('Shveps', 'Dima', 'Olegovich', id: 1, git: '@shveps_dimon', phone: valid_phone, telegram: '@shveps')
            expect(student.last_name).to eq('Shveps')
            expect(student.first_name).to eq('Dima')
            expect(student.surname).to eq('Olegovich')
            expect(student.id).to eq(1)
            expect(student.git).to eq('@shveps_dimon')
            expect(student.telegram).to eq('@shveps')
        end
    end

end