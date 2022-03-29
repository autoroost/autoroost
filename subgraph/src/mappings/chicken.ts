import { BigInt } from '@graphprotocol/graph-ts';
import {
  Transfer,
  LevelUp,
} from "../../generated/Chicken/Chicken"
import { Chicken, User } from "../../generated/schema"

export function handleTransfer(event: Transfer): void {
  let chicken = Chicken.load(event.params.tokenId.toHexString())

  if (chicken == null) {
    chicken = new Chicken(event.params.tokenId.toHexString())
    chicken.size = BigInt.fromString("100");
  }

  chicken.owner = event.params.to.toHexString();

  let user = User.load(event.params.to.toHexString())
  if (user == null) {
    user = new User(event.params.to.toHexString())
  }

  chicken.save();
  user.save();
}

export function handleLevelUp(event: LevelUp): void {
  let chicken = Chicken.load(event.params.chiknNumber.toHexString())

  chicken.size = event.params.newKg;

  chicken.save();
}
