from web3 import Web3
from web3.contract import ConciseContract
import json

w3 = Web3(Web3.HTTPProvider('https://sepolia.infura.io/v3/c5fc3812f38448758870ed1236e36a99'))

with open('CollectEverythingABI.json', 'r') as abi_definition:
    abi = json.load(abi_definition)

contract_address = '0xF07b18B9DC2E99Ee711C12694b4264fF0F3a045A'
contract = w3.eth.contract(address=contract_address, abi=abi)

event_filter = contract.events.PaymentReceived.createFilter(fromBlock='latest')

while True:
    try:
        events = event_filter.get_new_entries()

        for event in events:
            print('PaymentReceived event received:')
            print(vars(event.args))
            payer = event.args.payer
            amount = events.args.amount
    except KeyboardInterrupt:
        break
