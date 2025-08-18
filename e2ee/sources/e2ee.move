/// Module: e2ee
module e2ee::e2ee;

public struct Mail has key {
    id: UID,
    sender: address,
    receiver: address,
    blobId: vector<u8>
}

entry fun seal_approve(mail: &Mail, ctx: &mut TxContext){
    assert!(check_parties(mail, ctx), 1)
}

public fun check_parties(mail: &Mail, ctx: &mut TxContext): bool{
    if(ctx.sender() == mail.sender || ctx.sender() == mail.receiver){
        return true
    }else{
        return false
    }
}

public fun create_mail(receiver: address, blobId: vector<u8>, ctx: &mut TxContext) : Mail {
    Mail{
        id: object::new(ctx),
        sender: ctx.sender(),
        receiver: receiver,
        blobId: blobId,
    }

    // transfer::share_object<Mail>(mail);
}


#[test]
fun test_e2ee() {
    // use sui::test_scenario;

    // let sender = @0x1;
    let receiver = @0x2;
    let blobId = b"123abc";
    let mut ctx = tx_context::dummy();


    // let scenario = test_scenario::begin(sender);
    let mail = create_mail(receiver, blobId, &mut ctx);
    assert!(check_parties(&mail, &mut ctx), 1);
    transfer::share_object<Mail>(mail);
    

    // {
    // };

    // scenario.next_tx(receiver);
    // {
    //    assert!(seal_approve(&mail, &mut ctx), 1);
    // };
    // scenario.end();
    

    // assert!(check_parties(&mail, &mut ctx), 1);

    // // Test receiver
    // assert!(check_parties(&mail, &mut TxContext::default(receiver)), 1);

    // // Test other address
    // let other = @0x3;
    // assert!(!check_parties(&mail, &mut TxContext::default(other)), 0);
}


// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


