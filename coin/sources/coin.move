/// Module: coin
module coin::custom_coin;

use sui::coin::{Self, TreasuryCap, Coin};

public struct CUSTOM_COIN has drop {}

fun init(otw: CUSTOM_COIN, allow_global_pause: bool, ctx: &mut TxContext){
    let (treasury_cap, deny_cap, coin_metadata) = coin::create_regulated_currency_v2(
        otw,
        9,
        b"CC",
        b"CustomCoin",
        b"A custom coin on sui testnet",
        option::none(),
        alow_global_pause,
        ctx
    );

    transfer::public_freeze_object(coin_metadata);
    transfer::public_transfer(treasury_cap, ctx.sender());
    transfer::public_transfer(deny_cap, ctx.sender());
}

public fun mint(treasury_cap: &mut TreasuryCap<CUSTOM_COIN>, value: u64, recipient: address, ctx: &mut TxContext){
    let custom_coin = coin::mint(
        treasury_cap,
        value,
        ctx
    );
    transfer::public_transfer(custom_coin, recipient);
}

public fun burn(treasury_cap: &mut TreasuryCap<CUSTOM_COIN>, c: Coin<CUSTOM_COIN>): u64{
    coin::burn(treasury_cap, c)
}




// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


