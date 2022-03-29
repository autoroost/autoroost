import { BigInt } from "@graphprotocol/graph-ts"
import {
  AutoRoostCreated,
  FeeUpdate,
} from "../../generated/AutoRoostFactory/AutoRoostFactory"
import { AutoRoost as AutoRoostTemplate } from "../../generated/templates";
import { AutoRoostFactory as FactoryObject, AutoRoost, User } from "../../generated/schema"

export function handleCreation(event: AutoRoostCreated): void {
  let roost = new AutoRoost(event.params.roost.toHexString())

  roost.owner = event.params.owner.toHexString();

  let user = User.load(event.params.owner.toHexString())
  if (user == null) {
    user = new User(event.params.owner.toHexString())
  }

  AutoRoostTemplate.create(event.params.roost);
  roost.save();
  user.save();
}

export function handleFeeUpdate(event: FeeUpdate): void {
  let factory = FactoryObject.load(event.address.toHexString());

  if (factory == null) {
    factory = new FactoryObject(event.address.toHexString());
  }

  factory.fee = event.params.newFee;
  factory.save();
}
