function postCreate(){    
        for (strum in strumLines) {
            var charType = switch(strum.data.type) {
                case 0: "dad";
                case 1: "boyfriend";
                case 2: "gf";
            };
        if (charType == 1){
            remove(charType[0], true);
            charType[0] = new Character(strum.characters[0].x, strum.characters[0].y, "bf", stage.isCharFlipped(strum.data.type, (strum.data.type == 1)));
            add(charType[0]);
        }
    }
}