/// Module: objects
module objects::objects;

/// This module provides basic object management functionality.
public struct Object has key{
    id: UID,
    content: vector<u8>
}

public fun createObject(ctx: &mut TxContext, receiver: address) {
    let object = Object{
        id: object::new(ctx),
        content: b"Secret Content"
    };

    transfer::transfer(object, receiver);
}

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


