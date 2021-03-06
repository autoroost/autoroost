// THIS IS AN AUTOGENERATED FILE. DO NOT EDIT THIS FILE DIRECTLY.

import {
  TypedMap,
  Entity,
  Value,
  ValueKind,
  store,
  Address,
  Bytes,
  BigInt,
  BigDecimal
} from "@graphprotocol/graph-ts";

export class AutoRoostFactory extends Entity {
  constructor(id: string) {
    super();
    this.set("id", Value.fromString(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id !== null, "Cannot save AutoRoostFactory entity without an ID");
    assert(
      id.kind == ValueKind.STRING,
      "Cannot save AutoRoostFactory entity with non-string ID. " +
        'Considering using .toHex() to convert the "id" to a string.'
    );
    store.set("AutoRoostFactory", id.toString(), this);
  }

  static load(id: string): AutoRoostFactory | null {
    return store.get("AutoRoostFactory", id) as AutoRoostFactory | null;
  }

  get id(): string {
    let value = this.get("id");
    return value.toString();
  }

  set id(value: string) {
    this.set("id", Value.fromString(value));
  }

  get fee(): BigInt | null {
    let value = this.get("fee");
    if (value === null || value.kind == ValueKind.NULL) {
      return null;
    } else {
      return value.toBigInt();
    }
  }

  set fee(value: BigInt | null) {
    if (value === null) {
      this.unset("fee");
    } else {
      this.set("fee", Value.fromBigInt(value as BigInt));
    }
  }
}

export class AutoRoost extends Entity {
  constructor(id: string) {
    super();
    this.set("id", Value.fromString(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id !== null, "Cannot save AutoRoost entity without an ID");
    assert(
      id.kind == ValueKind.STRING,
      "Cannot save AutoRoost entity with non-string ID. " +
        'Considering using .toHex() to convert the "id" to a string.'
    );
    store.set("AutoRoost", id.toString(), this);
  }

  static load(id: string): AutoRoost | null {
    return store.get("AutoRoost", id) as AutoRoost | null;
  }

  get id(): string {
    let value = this.get("id");
    return value.toString();
  }

  set id(value: string) {
    this.set("id", Value.fromString(value));
  }

  get owner(): string {
    let value = this.get("owner");
    return value.toString();
  }

  set owner(value: string) {
    this.set("owner", Value.fromString(value));
  }

  get chickens(): Array<string> | null {
    let value = this.get("chickens");
    if (value === null || value.kind == ValueKind.NULL) {
      return null;
    } else {
      return value.toStringArray();
    }
  }

  set chickens(value: Array<string> | null) {
    if (value === null) {
      this.unset("chickens");
    } else {
      this.set("chickens", Value.fromStringArray(value as Array<string>));
    }
  }
}

export class User extends Entity {
  constructor(id: string) {
    super();
    this.set("id", Value.fromString(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id !== null, "Cannot save User entity without an ID");
    assert(
      id.kind == ValueKind.STRING,
      "Cannot save User entity with non-string ID. " +
        'Considering using .toHex() to convert the "id" to a string.'
    );
    store.set("User", id.toString(), this);
  }

  static load(id: string): User | null {
    return store.get("User", id) as User | null;
  }

  get id(): string {
    let value = this.get("id");
    return value.toString();
  }

  set id(value: string) {
    this.set("id", Value.fromString(value));
  }

  get roosts(): Array<string> | null {
    let value = this.get("roosts");
    if (value === null || value.kind == ValueKind.NULL) {
      return null;
    } else {
      return value.toStringArray();
    }
  }

  set roosts(value: Array<string> | null) {
    if (value === null) {
      this.unset("roosts");
    } else {
      this.set("roosts", Value.fromStringArray(value as Array<string>));
    }
  }

  get chickens(): Array<string> | null {
    let value = this.get("chickens");
    if (value === null || value.kind == ValueKind.NULL) {
      return null;
    } else {
      return value.toStringArray();
    }
  }

  set chickens(value: Array<string> | null) {
    if (value === null) {
      this.unset("chickens");
    } else {
      this.set("chickens", Value.fromStringArray(value as Array<string>));
    }
  }
}

export class Chicken extends Entity {
  constructor(id: string) {
    super();
    this.set("id", Value.fromString(id));
  }

  save(): void {
    let id = this.get("id");
    assert(id !== null, "Cannot save Chicken entity without an ID");
    assert(
      id.kind == ValueKind.STRING,
      "Cannot save Chicken entity with non-string ID. " +
        'Considering using .toHex() to convert the "id" to a string.'
    );
    store.set("Chicken", id.toString(), this);
  }

  static load(id: string): Chicken | null {
    return store.get("Chicken", id) as Chicken | null;
  }

  get id(): string {
    let value = this.get("id");
    return value.toString();
  }

  set id(value: string) {
    this.set("id", Value.fromString(value));
  }

  get owner(): string {
    let value = this.get("owner");
    return value.toString();
  }

  set owner(value: string) {
    this.set("owner", Value.fromString(value));
  }

  get roost(): string | null {
    let value = this.get("roost");
    if (value === null || value.kind == ValueKind.NULL) {
      return null;
    } else {
      return value.toString();
    }
  }

  set roost(value: string | null) {
    if (value === null) {
      this.unset("roost");
    } else {
      this.set("roost", Value.fromString(value as string));
    }
  }

  get size(): BigInt {
    let value = this.get("size");
    return value.toBigInt();
  }

  set size(value: BigInt) {
    this.set("size", Value.fromBigInt(value));
  }
}
