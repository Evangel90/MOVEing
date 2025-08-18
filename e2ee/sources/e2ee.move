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

public fun create_mail(receiver: address, blobId: vector<u8>, ctx: &mut TxContext){
    let mail = Mail{
        id: object::new(ctx),
        sender: ctx.sender(),
        receiver: receiver,
        blobId: blobId,
    };

    transfer::share_object<Mail>(mail);
}



// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


