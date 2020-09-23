db.createUser(
    {
        user : "sulemaez",
        pwd : "sulemaez",
        roles : [
            {
                role : "readWrite",
                db : "eds"
            }
        ]
    }
)