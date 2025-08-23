/// Module: coin
module coin::custom_coin;

use sui::coin::{Self, TreasuryCap};

public struct CustomCoin has drop {}

fun init(otw: CustomCoin, ctx: &mut TxContext){
    let (treasury_cap, coin_metadata) = coin::create_currency(
        otw,
        9,
        b"CC",
        b"CustomCoin",
        b"A custom coin on sui testnet",
        option::none(),
        ctx
    );

    transfer::public_freeze_object(coin_metadata);
    transfer::public_transfer(treasury_cap, ctx.sender());
}

public fun mint(treasury_cap: &mut TreasuryCap<CustomCoin>, value: u64, recipient: address, ctx: &mut TxContext){
    let custom_coin = coin::mint(
        treasury_cap,
        value,
        ctx
    );
    transfer::public_transfer(custom_coin, recipient);
}





// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


