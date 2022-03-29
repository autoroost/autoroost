// THIS IS AN AUTOGENERATED FILE. DO NOT EDIT THIS FILE DIRECTLY.

import {
  ethereum,
  JSONValue,
  TypedMap,
  Entity,
  Bytes,
  Address,
  BigInt
} from "@graphprotocol/graph-ts";

export class Deposit extends ethereum.Event {
  get params(): Deposit__Params {
    return new Deposit__Params(this);
  }
}

export class Deposit__Params {
  _event: Deposit;

  constructor(event: Deposit) {
    this._event = event;
  }

  get chickenId(): BigInt {
    return this._event.parameters[0].value.toBigInt();
  }

  get owner(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class OwnershipTransferred extends ethereum.Event {
  get params(): OwnershipTransferred__Params {
    return new OwnershipTransferred__Params(this);
  }
}

export class OwnershipTransferred__Params {
  _event: OwnershipTransferred;

  constructor(event: OwnershipTransferred) {
    this._event = event;
  }

  get previousOwner(): Address {
    return this._event.parameters[0].value.toAddress();
  }

  get newOwner(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class WithdrawChikn extends ethereum.Event {
  get params(): WithdrawChikn__Params {
    return new WithdrawChikn__Params(this);
  }
}

export class WithdrawChikn__Params {
  _event: WithdrawChikn;

  constructor(event: WithdrawChikn) {
    this._event = event;
  }

  get chickenId(): BigInt {
    return this._event.parameters[0].value.toBigInt();
  }

  get owner(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class WithdrawEggs extends ethereum.Event {
  get params(): WithdrawEggs__Params {
    return new WithdrawEggs__Params(this);
  }
}

export class WithdrawEggs__Params {
  _event: WithdrawEggs;

  constructor(event: WithdrawEggs) {
    this._event = event;
  }

  get amount(): BigInt {
    return this._event.parameters[0].value.toBigInt();
  }

  get owner(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class WithdrawFeed extends ethereum.Event {
  get params(): WithdrawFeed__Params {
    return new WithdrawFeed__Params(this);
  }
}

export class WithdrawFeed__Params {
  _event: WithdrawFeed;

  constructor(event: WithdrawFeed) {
    this._event = event;
  }

  get amount(): BigInt {
    return this._event.parameters[0].value.toBigInt();
  }

  get owner(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class AutoRoost extends ethereum.SmartContract {
  static bind(address: Address): AutoRoost {
    return new AutoRoost("AutoRoost", address);
  }

  chikn(): Address {
    let result = super.call("chikn", "chikn():(address)", []);

    return result[0].toAddress();
  }

  try_chikn(): ethereum.CallResult<Address> {
    let result = super.tryCall("chikn", "chikn():(address)", []);
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }

  egg(): Address {
    let result = super.call("egg", "egg():(address)", []);

    return result[0].toAddress();
  }

  try_egg(): ethereum.CallResult<Address> {
    let result = super.tryCall("egg", "egg():(address)", []);
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }

  fee(): BigInt {
    let result = super.call("fee", "fee():(uint256)", []);

    return result[0].toBigInt();
  }

  try_fee(): ethereum.CallResult<BigInt> {
    let result = super.tryCall("fee", "fee():(uint256)", []);
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toBigInt());
  }

  feeReceiver(): Address {
    let result = super.call("feeReceiver", "feeReceiver():(address)", []);

    return result[0].toAddress();
  }

  try_feeReceiver(): ethereum.CallResult<Address> {
    let result = super.tryCall("feeReceiver", "feeReceiver():(address)", []);
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }

  feed(): Address {
    let result = super.call("feed", "feed():(address)", []);

    return result[0].toAddress();
  }

  try_feed(): ethereum.CallResult<Address> {
    let result = super.tryCall("feed", "feed():(address)", []);
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }

  owner(): Address {
    let result = super.call("owner", "owner():(address)", []);

    return result[0].toAddress();
  }

  try_owner(): ethereum.CallResult<Address> {
    let result = super.tryCall("owner", "owner():(address)", []);
    if (result.reverted) {
      return new ethereum.CallResult();
    }
    let value = result.value;
    return ethereum.CallResult.fromValue(value[0].toAddress());
  }
}

export class ConstructorCall extends ethereum.Call {
  get inputs(): ConstructorCall__Inputs {
    return new ConstructorCall__Inputs(this);
  }

  get outputs(): ConstructorCall__Outputs {
    return new ConstructorCall__Outputs(this);
  }
}

export class ConstructorCall__Inputs {
  _call: ConstructorCall;

  constructor(call: ConstructorCall) {
    this._call = call;
  }

  get _fee(): BigInt {
    return this._call.inputValues[0].value.toBigInt();
  }

  get _chikn(): Address {
    return this._call.inputValues[1].value.toAddress();
  }

  get _egg(): Address {
    return this._call.inputValues[2].value.toAddress();
  }

  get _feed(): Address {
    return this._call.inputValues[3].value.toAddress();
  }
}

export class ConstructorCall__Outputs {
  _call: ConstructorCall;

  constructor(call: ConstructorCall) {
    this._call = call;
  }
}

export class DepositCall extends ethereum.Call {
  get inputs(): DepositCall__Inputs {
    return new DepositCall__Inputs(this);
  }

  get outputs(): DepositCall__Outputs {
    return new DepositCall__Outputs(this);
  }
}

export class DepositCall__Inputs {
  _call: DepositCall;

  constructor(call: DepositCall) {
    this._call = call;
  }

  get chiknIds(): Array<BigInt> {
    return this._call.inputValues[0].value.toBigIntArray();
  }
}

export class DepositCall__Outputs {
  _call: DepositCall;

  constructor(call: DepositCall) {
    this._call = call;
  }
}

export class FeedAllCall extends ethereum.Call {
  get inputs(): FeedAllCall__Inputs {
    return new FeedAllCall__Inputs(this);
  }

  get outputs(): FeedAllCall__Outputs {
    return new FeedAllCall__Outputs(this);
  }
}

export class FeedAllCall__Inputs {
  _call: FeedAllCall;

  constructor(call: FeedAllCall) {
    this._call = call;
  }
}

export class FeedAllCall__Outputs {
  _call: FeedAllCall;

  constructor(call: FeedAllCall) {
    this._call = call;
  }
}

export class FeedChiknsCall extends ethereum.Call {
  get inputs(): FeedChiknsCall__Inputs {
    return new FeedChiknsCall__Inputs(this);
  }

  get outputs(): FeedChiknsCall__Outputs {
    return new FeedChiknsCall__Outputs(this);
  }
}

export class FeedChiknsCall__Inputs {
  _call: FeedChiknsCall;

  constructor(call: FeedChiknsCall) {
    this._call = call;
  }

  get chiknIds(): Array<BigInt> {
    return this._call.inputValues[0].value.toBigIntArray();
  }
}

export class FeedChiknsCall__Outputs {
  _call: FeedChiknsCall;

  constructor(call: FeedChiknsCall) {
    this._call = call;
  }
}

export class RenounceOwnershipCall extends ethereum.Call {
  get inputs(): RenounceOwnershipCall__Inputs {
    return new RenounceOwnershipCall__Inputs(this);
  }

  get outputs(): RenounceOwnershipCall__Outputs {
    return new RenounceOwnershipCall__Outputs(this);
  }
}

export class RenounceOwnershipCall__Inputs {
  _call: RenounceOwnershipCall;

  constructor(call: RenounceOwnershipCall) {
    this._call = call;
  }
}

export class RenounceOwnershipCall__Outputs {
  _call: RenounceOwnershipCall;

  constructor(call: RenounceOwnershipCall) {
    this._call = call;
  }
}

export class TransferOwnershipCall extends ethereum.Call {
  get inputs(): TransferOwnershipCall__Inputs {
    return new TransferOwnershipCall__Inputs(this);
  }

  get outputs(): TransferOwnershipCall__Outputs {
    return new TransferOwnershipCall__Outputs(this);
  }
}

export class TransferOwnershipCall__Inputs {
  _call: TransferOwnershipCall;

  constructor(call: TransferOwnershipCall) {
    this._call = call;
  }

  get newOwner(): Address {
    return this._call.inputValues[0].value.toAddress();
  }
}

export class TransferOwnershipCall__Outputs {
  _call: TransferOwnershipCall;

  constructor(call: TransferOwnershipCall) {
    this._call = call;
  }
}

export class WithdrawCall extends ethereum.Call {
  get inputs(): WithdrawCall__Inputs {
    return new WithdrawCall__Inputs(this);
  }

  get outputs(): WithdrawCall__Outputs {
    return new WithdrawCall__Outputs(this);
  }
}

export class WithdrawCall__Inputs {
  _call: WithdrawCall;

  constructor(call: WithdrawCall) {
    this._call = call;
  }

  get chiknIds(): Array<BigInt> {
    return this._call.inputValues[0].value.toBigIntArray();
  }
}

export class WithdrawCall__Outputs {
  _call: WithdrawCall;

  constructor(call: WithdrawCall) {
    this._call = call;
  }
}

export class WithdrawAllCall extends ethereum.Call {
  get inputs(): WithdrawAllCall__Inputs {
    return new WithdrawAllCall__Inputs(this);
  }

  get outputs(): WithdrawAllCall__Outputs {
    return new WithdrawAllCall__Outputs(this);
  }
}

export class WithdrawAllCall__Inputs {
  _call: WithdrawAllCall;

  constructor(call: WithdrawAllCall) {
    this._call = call;
  }
}

export class WithdrawAllCall__Outputs {
  _call: WithdrawAllCall;

  constructor(call: WithdrawAllCall) {
    this._call = call;
  }
}

export class WithdrawChiknsCall extends ethereum.Call {
  get inputs(): WithdrawChiknsCall__Inputs {
    return new WithdrawChiknsCall__Inputs(this);
  }

  get outputs(): WithdrawChiknsCall__Outputs {
    return new WithdrawChiknsCall__Outputs(this);
  }
}

export class WithdrawChiknsCall__Inputs {
  _call: WithdrawChiknsCall;

  constructor(call: WithdrawChiknsCall) {
    this._call = call;
  }

  get chiknIds(): Array<BigInt> {
    return this._call.inputValues[0].value.toBigIntArray();
  }
}

export class WithdrawChiknsCall__Outputs {
  _call: WithdrawChiknsCall;

  constructor(call: WithdrawChiknsCall) {
    this._call = call;
  }
}

export class WithdrawEggsCall extends ethereum.Call {
  get inputs(): WithdrawEggsCall__Inputs {
    return new WithdrawEggsCall__Inputs(this);
  }

  get outputs(): WithdrawEggsCall__Outputs {
    return new WithdrawEggsCall__Outputs(this);
  }
}

export class WithdrawEggsCall__Inputs {
  _call: WithdrawEggsCall;

  constructor(call: WithdrawEggsCall) {
    this._call = call;
  }

  get chiknIds(): Array<BigInt> {
    return this._call.inputValues[0].value.toBigIntArray();
  }
}

export class WithdrawEggsCall__Outputs {
  _call: WithdrawEggsCall;

  constructor(call: WithdrawEggsCall) {
    this._call = call;
  }
}

export class WithdrawFeedCall extends ethereum.Call {
  get inputs(): WithdrawFeedCall__Inputs {
    return new WithdrawFeedCall__Inputs(this);
  }

  get outputs(): WithdrawFeedCall__Outputs {
    return new WithdrawFeedCall__Outputs(this);
  }
}

export class WithdrawFeedCall__Inputs {
  _call: WithdrawFeedCall;

  constructor(call: WithdrawFeedCall) {
    this._call = call;
  }
}

export class WithdrawFeedCall__Outputs {
  _call: WithdrawFeedCall;

  constructor(call: WithdrawFeedCall) {
    this._call = call;
  }
}