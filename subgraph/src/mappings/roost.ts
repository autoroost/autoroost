import { Address } from '@graphprotocol/graph-ts';
import {
  Deposit,
  OwnershipTransferred,
  WithdrawChikn,
} from "../../generated/templates/AutoRoost/AutoRoost"
import { Chicken, AutoRoost, User } from "../../generated/schema"

export function handleOwnershipTransferred(event: OwnershipTransferred): void {
  let roost = AutoRoost.load(event.address.toHexString())

  if (roost == null) {
    roost = new AutoRoost(event.address.toHexString())
  }

  // Entity fields can be set using simple assignments
  roost.owner = event.params.newOwner.toHexString();

  let user = User.load(event.params.newOwner.toHexString())
  if (user == null) {
    user = new User(event.params.newOwner.toHexString())
  }

  roost.save();
  user.save();
}

export function handleDeposit(event: Deposit): void {
  let chicken = Chicken.load(event.params.chickenId.toHexString())

  if (chicken == null) {
    chicken = new Chicken(event.params.chickenId.toHexString())
  }

  chicken.roost = event.address.toHexString();

  chicken.save();
}

export function handleWithdrawChikn(event: WithdrawChikn): void {
  let chicken = Chicken.load(event.params.chickenId.toHexString())

  if (chicken == null) {
    chicken = new Chicken(event.params.chickenId.toHexString())
  }

  chicken.roost = null;
  chicken.save();
}
