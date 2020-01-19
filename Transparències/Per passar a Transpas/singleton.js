// Singleton JS bona manera

function Universe ()
{
    var instance;
    
    Universe = function ()
    {
        return instance;
    }
    
    Universe.prototype = this;
    
    instance = new Universe();
    
    this.constructor = Universe; // no retorna undefined
    
    instance.start_time = 0;
    instance.bang = "Big";
    
    return instance;
};

Universe.prototype.nothing = true; // abans de crear instància

var uni = new Universe();

Universe.prototype.everything = true; // després de crear instància
